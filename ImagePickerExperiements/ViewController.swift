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
    @IBOutlet weak var shareButtonItem: UIBarButtonItem!
    
    let topFieldDelegate = memeTextFieldDelegate()
    let bottomFieldDelegate = memeTextFieldDelegate()
    var keyboardAlreadyShowing = false
    var bottomTextFieldEditing = false
    
    //Font For Memes
    let memeTextAttributes = [
        NSStrokeWidthAttributeName: -3.0,
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    ]
    
    //sets delegates, aligns and capitalizes all text in textFields, and hides navigation bar.
    override func viewDidLoad() {
        print("Meme Editor View Controller")
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        
        topTextField.adjustsFontSizeToFitWidth = true
        topTextField.minimumFontSize = 0.2
        bottomTextField.adjustsFontSizeToFitWidth = true
        bottomTextField.minimumFontSize = 0.2

        
        topTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        bottomTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        shareButtonItem.enabled = false

        
    }
    
    
    //function toggles whether the bottomtextfield is being edited. This variable makes it so the view only
    @IBAction func bottomTextFieldBeganEditing(sender: UITextField) {
        bottomTextFieldEditing = true
    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        //sets the type of fill in the imageView. This can be done in the storyboard or in code.
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //assigns the delegates to the previously set delegates. Each textfield needs to have its own delegate so that they act indepently.
        topTextField.delegate = topFieldDelegate
        bottomTextField.delegate = bottomFieldDelegate
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //Hides status bar for further cohesion in app.
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func pickImageButtonPressed(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickImageFromCamera(sender: AnyObject) {
        print("Camera Button Pressed")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let meme = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
        //Sets keyboardAlreadyShowing to false to ensure that the view stays in its apporpriate position. Loading another view can cause the keyboard to load impact the location of the view. 
        keyboardAlreadyShowing = false
        activityViewController.completionWithItemsHandler = {
            (s: String?, ok: Bool, items: [AnyObject]?, err: NSError?) -> Void in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButtonItem.enabled = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    //keyboard only moves if the bottom text field is being edited and the keyboard is not already showing.
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextFieldEditing {
            if keyboardAlreadyShowing != true {
                view.frame.origin.y -= getKeyboardHeight(notification)
                navigationToolbar.hidden = true
                toolbar.hidden = true
            }
            keyboardAlreadyShowing = true
        }
        
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //keyboard only hides if the bottomTextField is being edited and the keyboard is already showing.
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextFieldEditing {
            if keyboardAlreadyShowing {
                view.frame.origin.y += getKeyboardHeight(notification)
            }
            keyboardAlreadyShowing = false
            bottomTextFieldEditing = false
            toolbar.hidden = false
            navigationToolbar.hidden = false
        }
        
    }
    
    func generateMemedImage()->UIImage {
        //hide toolbar and navibar for screen capture.
        toolbar.hidden = true
        navigationToolbar.hidden = true
        
        
        //Render view to an Image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //presents toolbar and navigation toolbar for further user interaction.
        toolbar.hidden = false
        navigationToolbar.hidden = false
        
        
        return memedImage
    }
    
    
    //setup the save function as instructed by the course.
    func save() {
        let meme = Meme(topLabel: topTextField.text!, bottomLabel: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    

}

