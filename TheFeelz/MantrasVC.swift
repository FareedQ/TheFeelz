//
//  MantrasCVC.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class MantrasVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let manatraMemes = ["PM1", "PM2", "PM3", "PM4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewToLookPretty()
        supressCollectionViewGestures()
        setupGestureRecongizers()
    }
    
    func supressCollectionViewGestures(){
        guard let gestures = collectionView.gestureRecognizers else { return }
        for gesture in gestures {
            gesture.delaysTouchesBegan = true
        }
    }
    
    func setupGestureRecongizers(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "likeImage:")
        gestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func likeImage(sender: UITapGestureRecognizer){
        let locationInCollectionView = sender.locationInView(collectionView)
        guard let indexPath = collectionView.indexPathForItemAtPoint(locationInCollectionView) else {return}
        
        guard let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? MantraImageCell else { return }
        
        selectedCell.animateLike()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupViewToLookPretty()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? MantraImageCell else {return UICollectionViewCell()}
        myCell.image?.image = UIImage(named: manatraMemes[indexPath.row])
        return myCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manatraMemes.count
    }
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        collectionView.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        TitleLabel.textColor = Feelz.sharedInstance.getFontColour()
    }
}