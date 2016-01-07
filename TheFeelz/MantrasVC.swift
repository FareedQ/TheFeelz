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
        setupGestureRecongizers()
    }
    
    func setupGestureRecongizers(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "likeImage:")
        gestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func likeImage(sender: UITapGestureRecognizer){
        let locationInView = sender.locationInView(view)
        let locationInCollectionView = sender.locationInView(collectionView)
        guard let indexPath = collectionView.indexPathForItemAtPoint(locationInCollectionView) else {return}
        
        guard let selectedCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? MantraImageCell else { return }
        
        let myImage = getImage(selectedCell, yPositionOfTouch:locationInView.y)
        animateLike(myImage)

        
    }
    
    //I really wanted to use the image inside the cell and animate it, but it seems like I am running into problems accessing it. Instead I copy the image and place it on the top view and manipulate it from there.
    func getImage(selectedCell:MantraImageCell, yPositionOfTouch:CGFloat) -> UIImageView {
        let myImage = selectedCell.likeImage
        myImage.alpha = 1
        myImage.transform = CGAffineTransformMakeScale(0.3, 0.3)
        myImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myImage)
        
        let horizontalConstraint = NSLayoutConstraint(item: myImage, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: myImage, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: yPositionOfTouch)
        view.addConstraint(verticalConstraint)
        
        return myImage

    }
    
    func animateLike(myImage: UIImageView){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            myImage.transform = CGAffineTransformMakeScale(1.3, 1.3)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    myImage.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            myImage.alpha = 0
                        })
                })
        }
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