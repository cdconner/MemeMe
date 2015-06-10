//
//  MemeEditorController.swift
//  MemeMe
//
//  Created by Kelly Egan on 6/9/15.
//  Copyright (c) 2015 Kelly Egan. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        shareButton.enabled = (imageView.image != nil)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //MARK: Text field styles
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 48)!,
            NSStrokeWidthAttributeName : -1.0
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
        //TODO: Share Meme
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
    
    //MARK: Make meme
    func generateMemedImage() -> UIImage{
        topBar.hidden = true
        bottomBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topBar.hidden = false
        bottomBar.hidden = false
        
        return memedImage
    }
    
    
    //MARK: Keyboard show and hide
    func keyboardWillShow( notification: NSNotification ) {
        if( bottomTextField.isFirstResponder() ) {
            print("Show: \(self.view.frame.origin.y) -> ")
            self.view.frame.origin.y = -getKeyboardHeight(notification)
            print("\(self.view.frame.origin.y)\n")
        }
    }
    
    func keyboardWillHide( notification: NSNotification ) {
        if( bottomTextField.isFirstResponder() ) {
            print("Hide: \(self.view.frame.origin.y) -> ")
            self.view.frame.origin.y = 0
            print("\(self.view.frame.origin.y)\n")
        }
    }
    
    func getKeyboardHeight( notification: NSNotification ) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
}
