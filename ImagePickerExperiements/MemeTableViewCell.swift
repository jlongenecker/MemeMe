//
//  MemeTableViewCell.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 1/8/16.
//  Copyright © 2016 Echo Vector Technologies. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var memeImageView: UIImageView!
    

    @IBOutlet weak var memeLabel: UILabel!
    

}
