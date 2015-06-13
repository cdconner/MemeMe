//
//  MemeEditorController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var meme: Meme?

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        //MARK: IF provided with a Meme object load into view
        if let existingMeme = self.meme {
            topTextField.text = existingMeme.topText
            bottomTextField.text = existingMeme.bottomText
            imageView.image = existingMeme.originalImage
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        shareButton.enabled = (imageView.image != nil)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //MARK: Text field styles
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 84)!,
            NSStrokeWidthAttributeName : -2.0
        ]

        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        //MARK: Keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    //MARK: Buttons actions

    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (
            activityType: String!,
            completed: Bool,
            returnedItems: [AnyObject]!,
            activityError: NSError!) -> Void in
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.presentViewController( activityController, animated: true, completion: nil )
    }
 
    @IBAction func cancelMeme(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)    }
    
    @IBAction func useAlbumPicture(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Image picker response
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Text field functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = ""
    }
    
    //MARK: Save meme
    func save() {
        self.meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(self.meme!)
    }
    
    func generateMemedImage() -> UIImage{
        //Make sure text fields aren't currently be edited, otherwise
        //cursor will show or view will be shift because of keyboard.
        
        if (topTextField.isFirstResponder()) {
            topTextField.resignFirstResponder()
        }
        if(bottomTextField.isFirstResponder()) {
            bottomTextField.resignFirstResponder()
        }
        bottomBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        bottomBar.hidden = false
        
        return memedImage
    }
    
    //MARK: Keyboard show and hide
    func keyboardWillShow( notification: NSNotification ) {
        if( bottomTextField.isFirstResponder() ) {
            self.view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide( notification: NSNotification ) {
        if( bottomTextField.isFirstResponder() ) {
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight( notification: NSNotification ) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
}
