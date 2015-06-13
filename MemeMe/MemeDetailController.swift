//
//  MemeDetailController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeDetailController: UIViewController, MemeEditorControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = meme.memedImage
        
        if let navigationController = self.navigationController {
            let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "launchMemeEditor")
            self.navigationItem.rightBarButtonItem = editButton
        }
    }

    @IBAction func shareMeme(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [meme.memedImage!], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil )
    }
    

    
    func launchMemeEditor() {
        let editorController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorController") as! MemeEditorController
        println("\(meme.topText) \(meme.bottomText)")
        
        editorController.meme = meme
        editorController.delegate = self
        
        self.presentViewController(editorController, animated: true, completion: nil )
    }
    
    func memeSaved(memeEditor: MemeEditorController) {
        self.meme = memeEditor.meme
        imageView.image = self.meme.memedImage
    }
}
