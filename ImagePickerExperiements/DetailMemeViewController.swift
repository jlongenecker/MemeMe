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
        
        //Detail Meme View Controller. Available after selecting from MemeCollectionView or MemeTableView
        super.viewDidLoad()
        memeImage?.image = image

    }

}
