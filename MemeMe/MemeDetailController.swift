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
        self.meme = appDelegate.memes[memeIndex]
        
        imageView.image = self.meme.memedImage
        
        if let navigationController = self.navigationController {
            let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "launchMemeEditor")
            self.navigationItem.rightBarButtonItem = editButton
        }
    }
    
    func launchMemeEditor() {
        let editorController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorController") as! MemeEditorController
        println("\(meme.topText) \(meme.bottomText)")
        
        editorController.memeIndex = self.memeIndex
        editorController.meme = meme
        
        self.presentViewController(editorController, animated: true, completion: nil )
    }
}
