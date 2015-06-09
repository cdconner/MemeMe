//
//  MemeEditorController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO: Stylize text fields to match meme look
    }

    @IBAction func shareMeme(sender: AnyObject) {
        //TODO: Share Meme
    }
 
    @IBAction func cancelMeme(sender: AnyObject) {
        //TODO: Cancel meme creation and dismiss view
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        //TODO: Take picture and place in meme
    }
    
    @IBAction func useAlbumPicture(sender: AnyObject) {
        //TODO: Pick picture from album and place in Meme
    }
}
