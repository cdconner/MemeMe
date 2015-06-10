//
//  MemeEditorController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //TODO: Stylize text fields to match meme look
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 48)!,
            NSStrokeWidthAttributeName : 1.0,
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
    }

    @IBAction func shareMeme(sender: AnyObject) {
        //TODO: Share Meme
    }
 
    @IBAction func cancelMeme(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        //TODO: Take picture and place in meme
    }
    
    @IBAction func useAlbumPicture(sender: AnyObject) {
        //TODO: Pick picture from album and place in Meme
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
