//
//  CollectionViewController.swift
//  ImagePickerExperiements
//
//  Created by John Longenecker on 1/8/16.
//  Copyright © 2016 Echo Vector Technologies. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionCell"

class CollectionViewController: UICollectionViewController {
    
    var memes = [Meme]()

    
    override func viewWillAppear(animated: Bool) {
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        //collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        
        // Configure the cell
        cell.memeImageView?.image = meme.memedImage
        
    
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        
        let detailMemeViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailMemeViewController") as! DetailMemeViewController
        
        detailMemeViewController.image = meme.memedImage
        
        navigationController!.pushViewController(detailMemeViewController, animated: true)
    }
    





}
