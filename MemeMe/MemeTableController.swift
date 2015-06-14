//
//  MemeTableController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

//        if( appDelegate.memes.count == 0 ) {
//            launchMemeEditor()
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        
        //If you don't reload the table it won't see any changes!
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell", forIndexPath: indexPath) as! UITableViewCell
        
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.detailTextLabel?.text = meme.dateCreatedString
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailController") as! MemeDetailController
        
        detailController.memeIndex = indexPath.row
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(detailController, animated: true)
        }
    }

    @IBAction func createNewMeme(sender: AnyObject) {
        launchMemeEditor()
    }
    
    func launchMemeEditor() {
        let editorController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorController") as! MemeEditorController
        
        self.presentViewController(editorController, animated: true, completion: nil)
    }
}
