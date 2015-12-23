//
//  ViewController.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 12/14/15.
//  Copyright © 2015 Echo Vector Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationToolbar: UIToolbar!
    
    let topFieldDelegate = memeTextFieldDelegate()
    let bottomFieldDelegate = memeTextFieldDelegate()
    var keyboardAlreadyShowing = false
    
    //Font For Memes
    let memeTextAttributes = [
        NSStrokeWidthAttributeName: -3.0,
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        
    ]
    override func viewDidLoad() {
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        topTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        bottomTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        navigationToolbar.hidden = true
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        self.topTextField.delegate = topFieldDelegate
        self.bottomTextField.delegate = bottomFieldDelegate
        subscribeToKeyboardNotifications()
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    @IBAction func pickImageButtonPressed(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func pickImageFromCamera(sender: AnyObject) {
        print("Camera Button Pressed")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let meme = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            navigationToolbar.hidden = false
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if keyboardAlreadyShowing != true {
            view.frame.origin.y -= getKeyboardHeight(notification)
            navigationToolbar.hidden = true
        }
        keyboardAlreadyShowing = true
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardAlreadyShowing {
            view.frame.origin.y += getKeyboardHeight(notification)
            navigationToolbar.hidden = false
        }
        keyboardAlreadyShowing = false
    }
    
    func generateMemedImage()->UIImage {
        //TODO: Hide toolbar and navBar
        toolbar.hidden = true
        //navigationToolbar.hidden = true
        
        
        //Render view to an Image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //TODO: Show toolbar and navbar
        toolbar.hidden = false
        //navigationToolbar.hidden = false
        
        
        return memedImage
    }
    
    func save() ->Meme {
        let meme = Meme(topLabel: topTextField.text!, bottomLabel: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        return meme
    }
    
    

}

