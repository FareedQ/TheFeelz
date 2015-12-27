//
//  carouselViewController.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-21.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class CarouselSubVC: UIViewController {
    
    weak var mySplashVC:SplashVC!
    
    var imageViews = [UIImageView]()
    var horizontalConstraints = [NSLayoutConstraint]()
    let amountOfSelectors = 7 //Always have two selectors off screen on both sides
    
    //let myFeelz = Feelz()
    
    var selectedImageView:selectableImageView?
    
    // The selectableImageView enum has a raw value
    enum selectableImageView {
        case leftImage
        case middleImage
        case rightImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelectorImageViewsWithConstraints()
        spaceOutSelectorsThroughConstraints()
        loadImagesToSelectors()
        mySplashVC.checkBackground()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "doTapGesture:")
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func doTapGesture(sender: UITapGestureRecognizer){
        mySplashVC.performSegueWithIdentifier("SplashToMain", sender: mySplashVC)
    }
    
    func doPanGesture(sender: UIPanGestureRecognizer){
        let currentPosition = sender.locationInView(view).x
        
        switch sender.state {
        case .Began:
            selectedImageView = whichImageSelected(sender.locationInView(view))
            break
            
        case .Changed:
            guard let mySelectedImageView = selectedImageView else {return}
            spaceOutSelectorsThroughConstraints(currentPosition, selectedImageView: mySelectedImageView)
            break
            
        case .Ended:
            adjustSelectionImagesBasedOnPosition(currentPosition, width: view.bounds.width)
            mySplashVC.checkBackground()
            break
            
        default:
            break
            
        }
    }
    
    func whichImageSelected(currentTouchInView:CGPoint) -> selectableImageView{

        var myImageViewCounter = 0
        for imageView in imageViews {
            if(imageView.frame.contains(currentTouchInView)){
                switch myImageViewCounter{
                case 2:
                    return .leftImage
                case 3:
                    return .middleImage
                case 4:
                    return .rightImage
                default:
                    break
                }
                break
            }
            myImageViewCounter++
        }
        
        //if for any reason this image selection breaks the return the middle image selected
        return .middleImage
    }
    
    func adjustSelectionImagesBasedOnPosition(currentPosition:CGFloat, width:CGFloat){
        switch currentPosition{
        case width*3/4 ... width+10:
            if selectedImageView == .rightImage { break }
            toDecrement()
            if selectedImageView == .leftImage { toDecrement() }
            break
        case -10 ... width*1/4:
            if selectedImageView == .leftImage { break }
            toIncrement()
            if selectedImageView == .rightImage { toIncrement() }
            break
        default:
            if selectedImageView == .leftImage { toDecrement() }
            if selectedImageView == .rightImage { toIncrement() }
            break
        }
    }
    
    func toIncrement(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        myAppDelegate.myFeelz.incrementIndex()
        
        incrementCurrentSelectorConstraintsAndImage()
        loadImagesToSelectors()
    }
    
    func toDecrement(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        myAppDelegate.myFeelz.decrementIndex()
        
        decrementCurrentSelectorConstraintsAndImage()
        loadImagesToSelectors()
    }
    
    func incrementCurrentSelectorConstraintsAndImage(){
        let tempHorizontalConstraint = horizontalConstraints[0]
        horizontalConstraints.removeFirst()
        horizontalConstraints.append(tempHorizontalConstraint)
        
        let tempImageView = imageViews[0]
        imageViews.removeFirst()
        imageViews.append(tempImageView)
    }
    
    func decrementCurrentSelectorConstraintsAndImage(){
        let tempHorizontalConstraint = horizontalConstraints[horizontalConstraints.count-1]
        horizontalConstraints.removeLast()
        var tempHorizontalConstraints = horizontalConstraints.reverse() as [NSLayoutConstraint]
        tempHorizontalConstraints.append(tempHorizontalConstraint)
        horizontalConstraints = tempHorizontalConstraints.reverse()
        
        let tempImageView = imageViews[imageViews.count - 1]
        imageViews.removeLast()
        var tempImageViews = imageViews.reverse() as [UIImageView]
        tempImageViews.append(tempImageView)
        imageViews = tempImageViews.reverse()
    }
    
    func spaceOutSelectorsThroughConstraints(){
        let width = self.view.bounds.width
        let multiplier = width * 0.5
        var increment:CGFloat = floor(CGFloat(amountOfSelectors)/2) * -1
        for constraint in horizontalConstraints {
            constraint.constant = multiplier * increment
            increment++
        }
    }
    
    func spaceOutSelectorsThroughConstraints(var givenScreenTouch:CGFloat, selectedImageView:selectableImageView){
        let width = self.view.bounds.width
        let multiplier = width * 0.5
        var increment:CGFloat = floor(CGFloat(amountOfSelectors)/2) * -1
        
        //Need to adjust the area being selected based on the image being selected
        switch selectedImageView {
        case .leftImage:
            break
        case .middleImage:
            givenScreenTouch = givenScreenTouch - multiplier
        case .rightImage:
            givenScreenTouch = givenScreenTouch - multiplier * 2
        }
        
        for constraint in horizontalConstraints {
            constraint.constant = givenScreenTouch + multiplier * increment
            increment++
        }
    }
    
    func loadImagesToSelectors(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        let amountOfImagesFromTheLeftUntilTheMiddle = Int(floor(CGFloat(amountOfSelectors)/2)) * -1
        var currentSelector = myAppDelegate.myFeelz.index + amountOfImagesFromTheLeftUntilTheMiddle
        if currentSelector < 0 { currentSelector += myAppDelegate.myFeelz.emotionsArray.count }
        for imageView in imageViews {
            imageView.image = UIImage(named:myAppDelegate.myFeelz.emotionsArray[currentSelector%myAppDelegate.myFeelz.emotionsArray.count].Name)
            currentSelector += 1
            if currentSelector == myAppDelegate.myFeelz.emotionsArray.count { currentSelector = 0 }
        }
    }
    
    func setupSelectorImageViewsWithConstraints(){
        for _ in 1...amountOfSelectors {
            let imageView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            imageViews.append(imageView)
            
            let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            view.addConstraint(horizontalConstraint)
            horizontalConstraints.append(horizontalConstraint)
            
            let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
            view.addConstraint(verticalConstraint)
            
            let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Height, multiplier: 15/16, constant: 0)
            view.addConstraint(heightConstraint)
            
            let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
            view.addConstraint(widthConstraint)
        }
    }
}
