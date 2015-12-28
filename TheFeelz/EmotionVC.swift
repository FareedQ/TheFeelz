//
//  ViewController.swift
//  SelectionAnimation
//
//  Created by FareedQ on 2015-12-13.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class EmotionVC: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var lblDictionaryOutput: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var SelectionViewTopContraint: NSLayoutConstraint!
    
    let SELECTIONVIEWMOVEIN:CGFloat = -108
    
    weak var mySelectionSubVC:SelectionSubVC!
    var originalMainImageFrame = CGRect()
    var originalFirstImageFrame = CGRect()
    var originalSecondImageFrame = CGRect()
    var originalThirdImageFrame = CGRect()
    var originalFourthImageFrame = CGRect()
    
    var selectionArrayInCurrentView = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalMainImageFrame = mainImage.frame
        originalFirstImageFrame = mySelectionSubVC.img1.frame
        originalSecondImageFrame = mySelectionSubVC.img2.frame
        originalThirdImageFrame = mySelectionSubVC.img3.frame
        originalFourthImageFrame = mySelectionSubVC.img4.frame
        
        loadImages()
        
        SelectionViewTopContraint.constant = SELECTIONVIEWMOVEIN
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "selectedMainImage:")
        gestureRecognizer.minimumPressDuration = 0.2
        self.view.addGestureRecognizer(gestureRecognizer)
        
        let myDictionary = DictionaryAPI()
        lblDictionaryOutput.text = myDictionary.execute(Feelz.sharedInstance.getSelectedEmotion())
        
        checkBackground()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectionSegue" {
            guard let tempVC = segue.destinationViewController as? SelectionSubVC else {return}
            mySelectionSubVC = tempVC
        }
    }
    
    func loadImages(){
        mainImage.image = UIImage(named: Feelz.sharedInstance.getSelectedEmotion())
        mySelectionSubVC.img1.image = UIImage(named: Feelz.sharedInstance.getEmotionAt(1))
        mySelectionSubVC.img2.image = UIImage(named: Feelz.sharedInstance.getEmotionAt(2))
        mySelectionSubVC.img3.image = UIImage(named: Feelz.sharedInstance.getEmotionAt(3))
        mySelectionSubVC.img4.image = UIImage(named: Feelz.sharedInstance.getEmotionAt(4))
        
        for x in Feelz.sharedInstance.index ... (Feelz.sharedInstance.index+4) {
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
            
            let myDictionary = DictionaryAPI()
            lblDictionaryOutput.text = myDictionary.execute(Feelz.sharedInstance.getSelectedEmotion())
            
            checkBackground()
            break
        default:
            break
        }
        
    }
    
    func animateToSelectedOption(touchPosition:CGPoint){
        
        if(originalFirstImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img1)
        } else if(originalSecondImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img2)
        } else if(originalThirdImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img3)
        } else if(originalFourthImageFrame.contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img4)
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
        Feelz.sharedInstance.index = selectedEmotion
        let tempSelection = selectedEmotion
        selectedEmotion = currentEmotion
        currentEmotion = tempSelection
    }
    
    func animateOptionSelected(selectedImage:UIImageView){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.returnSelectableImagesToScale()
            selectedImage.frame = self.originalMainImageFrame
            self.mySelectionSubVC.view.bringSubviewToFront(selectedImage)
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
        
        mainImage.image = UIImage(named: Feelz.sharedInstance.emotionsArray[selectionArrayInCurrentView[0]].Name)
        mySelectionSubVC.img1.image = UIImage(named: Feelz.sharedInstance.emotionsArray[selectionArrayInCurrentView[1]].Name)
        mySelectionSubVC.img2.image = UIImage(named: Feelz.sharedInstance.emotionsArray[selectionArrayInCurrentView[2]].Name)
        mySelectionSubVC.img3.image = UIImage(named: Feelz.sharedInstance.emotionsArray[selectionArrayInCurrentView[3]].Name)
        mySelectionSubVC.img4.image = UIImage(named: Feelz.sharedInstance.emotionsArray[selectionArrayInCurrentView[4]].Name)
        
        mySelectionSubVC.img1.frame = self.originalFirstImageFrame
        mySelectionSubVC.img2.frame = self.originalSecondImageFrame
        mySelectionSubVC.img3.frame = self.originalThirdImageFrame
        mySelectionSubVC.img4.frame = self.originalFourthImageFrame
        
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
        mySelectionSubVC.img1.frame = originalFirstImageFrame
        mySelectionSubVC.img2.frame = originalSecondImageFrame
        mySelectionSubVC.img3.frame = originalThirdImageFrame
        mySelectionSubVC.img4.frame = originalFourthImageFrame
    }

    func alertMessage(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let okay = UIAlertAction(title: "Okay", style: .Default) { (UIAlertAction) -> Void in
        }
        alert.addAction(okay)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func checkBackground(){
        view.backgroundColor = Feelz.sharedInstance.getBrightColour()
    }
    
}

