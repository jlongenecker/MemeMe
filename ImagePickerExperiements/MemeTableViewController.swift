//
//  MemeTableViewController.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 1/7/16.
//  Copyright © 2016 Echo Vector Technologies. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes = [Meme]()
    let reuseIdentifier = "MemeTableCell"



    override func viewWillAppear(animated: Bool) {
        print("MemeTableViewController")
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  memes.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        reloadInputViews()
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        let meme = memes[indexPath.row]
        let cellLabel = meme.topLabel + "..." + meme.bottomLabel
        cell.textLabel?.text = cellLabel
        cell.imageView?.image = meme.memedImage
        
        return cell
    }

//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }


}
