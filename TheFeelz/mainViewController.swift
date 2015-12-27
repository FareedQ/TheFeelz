//
//  ViewController.swift
//  SelectionAnimation
//
//  Created by FareedQ on 2015-12-13.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {

    
    weak var mySplashViewController:splashViewController!
    
    @IBOutlet weak var lblDictionaryOutput: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var SelectionViewTopContraint: NSLayoutConstraint!
    
    let SELECTIONVIEWMOVEIN:CGFloat = -108
    
    weak var mySelectionVC:selectionViewController!
    var originalMainImageFrame = CGRect()
    var originalFirstImageFrame = CGRect()
    var originalSecondImageFrame = CGRect()
    var originalThirdImageFrame = CGRect()
    var originalFourthImageFrame = CGRect()
    
    var selectionArrayInCurrentView = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalMainImageFrame = mainImage.frame
        originalFirstImageFrame = mySelectionVC.img1.frame
        originalSecondImageFrame = mySelectionVC.img2.frame
        originalThirdImageFrame = mySelectionVC.img3.frame
        originalFourthImageFrame = mySelectionVC.img4.frame
        
        loadImages()
        
        SelectionViewTopContraint.constant = SELECTIONVIEWMOVEIN
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "selectedMainImage:")
        gestureRecognizer.minimumPressDuration = 0.2
        self.view.addGestureRecognizer(gestureRecognizer)
        
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        let myDictionary = DictionaryAPI()
        lblDictionaryOutput.text = myDictionary.execute(myAppDelegate.myFeelz.getSelectedEmotion())
        
        checkBackground()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectionSegue" {
            guard let tempVC = segue.destinationViewController as? selectionViewController else {return}
            mySelectionVC = tempVC
        }
    }
    
    func loadImages(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        let myFeelz = myAppDelegate.myFeelz
        mainImage.image = UIImage(named: myFeelz.getSelectedEmotion())
        mySelectionVC.img1.image = UIImage(named: myFeelz.getEmotionAt(1))
        mySelectionVC.img2.image = UIImage(named: myFeelz.getEmotionAt(2))
        mySelectionVC.img3.image = UIImage(named: myFeelz.getEmotionAt(3))
        mySelectionVC.img4.image = UIImage(named: myFeelz.getEmotionAt(4))
        
        for x in myFeelz.index ... (myFeelz.index+4) {
            selectionArrayInCurrentView.append(x%5)
        }
    }
    
    func selectedMainImage(sender: UIGestureRecognizer){
        let touchPosition = sender.locationInView(self.view)
        
        switch sender.state {
        case .Began:
            if mainImage.frame.contains(touchPosition){
                animateLoweringTheSelectionView(touchPosition)
            }
            break
        case .Changed:
            self.mainImage.center = touchPosition
            animateToSelectedOption(touchPosition)
            break
        case .Ended:
            changeToSelectedOption(touchPosition)
            switchToTheSelectedOption()
            animatePuttingThingsBackInTheirPlaces()
            
            guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
            let myDictionary = DictionaryAPI()
            lblDictionaryOutput.text = myDictionary.execute(myAppDelegate.myFeelz.getSelectedEmotion())
            
            checkBackground()
            break
        default:
            break
        }
        
    }
    
    func animateToSelectedOption(touchPosition:CGPoint){
        
        if(originalFirstImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionVC.img1)
        } else if(originalSecondImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionVC.img2)
        } else if(originalThirdImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionVC.img3)
        } else if(originalFourthImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionVC.img4)
        } else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.returnSelectableImagesToScale()
            })
        }
    }
    
    func changeToSelectedOption(touchPosition:CGPoint){
        
        if(originalFirstImageFrame.contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[1])
        } else if(originalSecondImageFrame.contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[2])
        } else if(originalThirdImageFrame.contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[3])
        } else if(originalFourthImageFrame.contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[4])
        } else {
        }
    }
    
    func swapValuesInSelectionArray(inout currentEmotion:Int, inout selectedEmotion:Int){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        myAppDelegate.myFeelz.index = selectedEmotion
        let tempSelection = selectedEmotion
        selectedEmotion = currentEmotion
        currentEmotion = tempSelection
    }
    
    func animateOptionSelected(selectedImage:UIImageView){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.returnSelectableImagesToScale()
            selectedImage.frame = self.originalMainImageFrame
            self.mySelectionVC.view.bringSubviewToFront(selectedImage)
        })
    }
    
    func animatePuttingThingsBackInTheirPlaces(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.SelectionViewTopContraint.constant = self.SELECTIONVIEWMOVEIN
            self.view.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.mainImage.transform = CGAffineTransformMakeScale(1, 1)
                    self.mainImage.frame = self.originalMainImageFrame
                    self.view.bringSubviewToFront(self.mainImage)
                    self.mainImage.alpha = 1
                })
        })
    }
    
    func animateLoweringTheSelectionView(touchPosition:CGPoint){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainImage.transform = CGAffineTransformMakeScale(0.3, 0.3)
            self.mainImage.alpha = 0.3
            self.mainImage.center = touchPosition
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.SelectionViewTopContraint.constant = 0
                    self.view.layoutIfNeeded()
                    self.mainImage.center = touchPosition
                })
        })
    }
    
    func switchToTheSelectedOption(){
        
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        let myFeelz = myAppDelegate.myFeelz
        mainImage.image = UIImage(named: myFeelz.emotionsArray[selectionArrayInCurrentView[0]].Name)
        mySelectionVC.img1.image = UIImage(named: myFeelz.emotionsArray[selectionArrayInCurrentView[1]].Name)
        mySelectionVC.img2.image = UIImage(named: myFeelz.emotionsArray[selectionArrayInCurrentView[2]].Name)
        mySelectionVC.img3.image = UIImage(named: myFeelz.emotionsArray[selectionArrayInCurrentView[3]].Name)
        mySelectionVC.img4.image = UIImage(named: myFeelz.emotionsArray[selectionArrayInCurrentView[4]].Name)
        
        mySelectionVC.img1.frame = self.originalFirstImageFrame
        mySelectionVC.img2.frame = self.originalSecondImageFrame
        mySelectionVC.img3.frame = self.originalThirdImageFrame
        mySelectionVC.img4.frame = self.originalFourthImageFrame
        
        mainImage.transform = CGAffineTransformMakeScale(1, 1)
        mainImage.frame = self.originalMainImageFrame
        mainImage.alpha = 1
        view.sendSubviewToBack(mainImage)
    }
    
    func swapImages(inout FirstImage:UIImage, inout SecondImage:UIImage){
        let tempImage = FirstImage
        FirstImage = SecondImage
        SecondImage = tempImage
    }

    func returnSelectableImagesToScale(){
        mySelectionVC.img1.frame = originalFirstImageFrame
        mySelectionVC.img2.frame = originalSecondImageFrame
        mySelectionVC.img3.frame = originalThirdImageFrame
        mySelectionVC.img4.frame = originalFourthImageFrame
    }

    func alertMessage(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let okay = UIAlertAction(title: "Okay", style: .Default) { (UIAlertAction) -> Void in
        }
        alert.addAction(okay)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func checkBackground(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        view.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
    }
    
}

