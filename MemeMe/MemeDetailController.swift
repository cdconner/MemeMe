//
//  MemeDetailController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeDetailController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var memeIndex: Int!
    var meme: Meme!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        meme = appDelegate.memes[memeIndex]
        
        imageView.image = meme.memedImage
        
        if let navigationController = self.navigationController {
            let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "launchMemeEditor")
            let deleteButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteMeme")
            navigationItem.rightBarButtonItems = [editButton, deleteButton]
        }
    }
    
    func launchMemeEditor() {
        let editorController = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorController") as! MemeEditorController
        
        editorController.memeIndex = memeIndex
        editorController.meme = meme
        
        presentViewController(editorController, animated: true, completion: nil )
    }
    
    func deleteMeme() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.removeAtIndex(memeIndex)
        println("La la la deleting \(self.memeIndex)")
        navigationController?.popViewControllerAnimated(true)
    }
}
