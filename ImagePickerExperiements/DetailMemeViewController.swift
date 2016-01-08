//
//  DetailMemeViewController.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 1/7/16.
//  Copyright © 2016 Echo Vector Technologies. All rights reserved.
//

import UIKit

class DetailMemeViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memeImage?.image = image

        // Do any additional setup after loading the view.
    }

}
