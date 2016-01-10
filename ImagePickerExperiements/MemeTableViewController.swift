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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        let cellLabel = meme.topLabel + " " + meme.bottomLabel
        cell.memeImageView?.image = meme.memedImage
        cell.memeLabel?.text = cellLabel
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        let detailMemeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailMemeViewController") as! DetailMemeViewController
        
        detailMemeViewController.image = meme.memedImage
        
        self.navigationController!.pushViewController(detailMemeViewController, animated: true)
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
}
