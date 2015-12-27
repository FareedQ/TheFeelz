//
//  MantrasCVC.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class MantrasVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let manatraMemes = ["PM1", "PM2", "PM3", "PM4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkBackground()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? MantraImageCell else {return UICollectionViewCell()}
        myCell.image?.image = UIImage(named: manatraMemes[indexPath.row])
        return myCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manatraMemes.count
    }
    
    func checkBackground(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        view.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
        collectionView.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
    }
}
