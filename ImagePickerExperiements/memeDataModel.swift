//
//  memeDataModel.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 12/22/15.
//  Copyright © 2015 Echo Vector Technologies. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topLabel: String
    var bottomLabel: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topLabel: String, bottomLabel: String, originalImage: UIImage, memedImage: UIImage) {
        self.topLabel = topLabel
        self.bottomLabel = bottomLabel
        self.originalImage = originalImage
        self.memedImage = memedImage
        
    }

    
}