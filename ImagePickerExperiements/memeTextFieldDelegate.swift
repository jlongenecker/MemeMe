//
//  File.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 12/15/15.
//  Copyright © 2015 Echo Vector Technologies. All rights reserved.
//

import Foundation
import UIKit

class memeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var hasUserEnteredText = false
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }

    
    func textFieldDidBeginEditing(textField: UITextField) {
        if hasUserEnteredText != true {
            textField.text = ""
        }
        hasUserEnteredText = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
