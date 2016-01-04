//
//  ViewController.swift
//  SelectionAnimation
//
//  Created by FareedQ on 2015-12-13.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class EmotionVC: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var mySelectionSubVC:SelectionSubVC!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var SelectionViewTopContraint: NSLayoutConstraint!
    let SELECTIONVIEWMOVEIN:CGFloat = -108
    var originalFrameArray = [CGRect]()
    var selectionArrayInCurrentView = [Int]()
    var selectionDidHappen:Bool = false
    
    @IBOutlet weak var emotionTitleLabel: UILabel!
    @IBOutlet weak var dictionaryOutputLabel: UILabel!
    @IBOutlet weak var synonym1: UIButton!
    @IBOutlet weak var synonym2: UIButton!
    @IBOutlet weak var synonym3: UIButton!
    var synonymButtonArray = [UIButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalFrameArray = [mainImage.frame, mySelectionSubVC.img1.frame, mySelectionSubVC.img2.frame, mySelectionSubVC.img3.frame, mySelectionSubVC.img4.frame]
        synonymButtonArray = [synonym1, synonym2, synonym3]
        
        loadImages()
        
        SelectionViewTopContraint.constant = SELECTIONVIEWMOVEIN
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "selectedMainImage:")
        gestureRecognizer.minimumPressDuration = 0.2
        self.view.addGestureRecognizer(gestureRecognizer)
        
        getContent(Feelz.sharedInstance.getSelectedEmotion())
        
        setupViewToLookPretty()
        
    }
    
    func getContent(word:String){
        let myDictionary = DictionaryAPI()
        emotionTitleLabel.text = word
        dictionaryOutputLabel.text = myDictionary.execute(word)
        setupSynonyms(myDictionary, currentWord: word)
    }
    
    func setupSynonyms(myDictionary:DictionaryAPI, currentWord:String){
        for button in synonymButtonArray {
            button.setTitle("", forState: .Normal)
        }
        var mySynonyms = [String]()
        mySynonyms = myDictionary.synonymArray
        let initCount = mySynonyms.count
        if initCount < 3 {
            for _ in 0...2 - initCount {
                let mySpareSynonyms = SpareSynonyms()
                var allWords = mySynonyms
                allWords.append(currentWord)
                mySynonyms.append(mySpareSynonyms.returnRandomSynonym(Feelz.sharedInstance.getSelectedEmotion(), givenWords: allWords))
            }
        }
        for x in 0...2 {
            synonymButtonArray[x].setTitle(mySynonyms[x], forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectionSegue" {
            guard let tempVC = segue.destinationViewController as? SelectionSubVC else {return}
            mySelectionSubVC = tempVC
        }
    }
    
    func loadImages(){
        mainImage.image = UIImage(named: Feelz.sharedInstance.getSelectedEmotionImageTitle())
        mySelectionSubVC.img1.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleWith(1))
        mySelectionSubVC.img2.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleWith(2))
        mySelectionSubVC.img3.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleWith(3))
        mySelectionSubVC.img4.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleWith(4))
        
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
            swapSelectionToSelectedOption(touchPosition)
            animateSwitchOfSelectedOption()
            animatePuttingThingsBackInTheirPlaces()
            
            getContent(Feelz.sharedInstance.getSelectedEmotion())
            
            setupViewToLookPretty()
            break
        default:
            break
        }
        
    }
    
    func animateToSelectedOption(touchPosition:CGPoint){
        
        selectionDidHappen = true
        if(originalFrameArray[1].contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img1)
        } else if(originalFrameArray[2].contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img2)
        } else if(originalFrameArray[3].contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img3)
        } else if(originalFrameArray[4].contains(touchPosition)){
            animateOptionSelected(self.mySelectionSubVC.img4)
        } else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.returnSelectableImagesToScale()
            })
            selectionDidHappen = false
        }
    }
    
    func swapSelectionToSelectedOption(touchPosition:CGPoint){
        
        if(originalFrameArray[1].contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[1])
        } else if(originalFrameArray[2].contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[2])
        } else if(originalFrameArray[3].contains(touchPosition)){
            swapValuesInSelectionArray(&selectionArrayInCurrentView[0], selectedEmotion: &selectionArrayInCurrentView[3])
        } else if(originalFrameArray[4].contains(touchPosition)){
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
            selectedImage.frame = self.originalFrameArray[0]
            self.mySelectionSubVC.view.bringSubviewToFront(selectedImage)
        })
    }
    
    func animatePuttingThingsBackInTheirPlaces(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.SelectionViewTopContraint.constant = self.SELECTIONVIEWMOVEIN
            self.view.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                self.view.bringSubviewToFront(self.mainImage)
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.mainImage.transform = CGAffineTransformMakeScale(1, 1)
                    self.mainImage.frame = self.originalFrameArray[0]
                    self.mainImage.alpha = 1
                    self.titleLabel.alpha = 1
                    self.showContent()
                })
        })
    }
    
    func showContent(){
        self.emotionTitleLabel.alpha = 1
        self.dictionaryOutputLabel.alpha = 1
        for syn in self.synonymButtonArray {
            syn.alpha = 1
        }
    }
    
    func animateLoweringTheSelectionView(touchPosition:CGPoint){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.titleLabel.alpha = 0
            self.hideContent()
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
    
    func hideContent(){
        self.emotionTitleLabel.alpha = 0
        self.dictionaryOutputLabel.alpha = 0
        for syn in self.synonymButtonArray {
            syn.alpha = 0
        }
    }
    
    func animateSwitchOfSelectedOption(){
        
        mainImage.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleAt(selectionArrayInCurrentView[0]))
        mySelectionSubVC.img1.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleAt(selectionArrayInCurrentView[1]))
        mySelectionSubVC.img2.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleAt(selectionArrayInCurrentView[2]))
        mySelectionSubVC.img3.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleAt(selectionArrayInCurrentView[3]))
        mySelectionSubVC.img4.image = UIImage(named: Feelz.sharedInstance.getEmotionImageTitleAt(selectionArrayInCurrentView[4]))
        
        mySelectionSubVC.img1.frame = self.originalFrameArray[1]
        mySelectionSubVC.img2.frame = self.originalFrameArray[2]
        mySelectionSubVC.img3.frame = self.originalFrameArray[3]
        mySelectionSubVC.img4.frame = self.originalFrameArray[4]
        
        if selectionDidHappen {
            self.mainImage.transform = CGAffineTransformMakeScale(1, 1)
            self.mainImage.frame = self.originalFrameArray[0]
            self.mainImage.alpha = 1
            self.view.sendSubviewToBack(self.mainImage)
        } else {
            UIView.animateWithDuration(0.3) { () -> Void in
                self.mainImage.transform = CGAffineTransformMakeScale(1, 1)
                self.mainImage.frame = self.originalFrameArray[0]
                self.mainImage.alpha = 1
                self.view.sendSubviewToBack(self.mainImage)
            }
        }
    }
    
    func swapImages(inout FirstImage:UIImage, inout SecondImage:UIImage){
        let tempImage = FirstImage
        FirstImage = SecondImage
        SecondImage = tempImage
    }

    func returnSelectableImagesToScale(){
        mySelectionSubVC.img1.frame = originalFrameArray[1]
        mySelectionSubVC.img2.frame = originalFrameArray[2]
        mySelectionSubVC.img3.frame = originalFrameArray[3]
        mySelectionSubVC.img4.frame = originalFrameArray[4]
    }
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        titleLabel.textColor = Feelz.sharedInstance.getFontColour()
        emotionTitleLabel.textColor = Feelz.sharedInstance.getFontColour()
        dictionaryOutputLabel.textColor = Feelz.sharedInstance.getFontColour()
        for synonym in synonymButtonArray {
            synonym.setTitleColor(Feelz.sharedInstance.getLinkColour(), forState: .Normal)
        }
    }
    
    @IBAction func synonymButton1(sender: UIButton) {
        synonymButtonAction(sender)
    }
    
    @IBAction func synonymButton2(sender: UIButton) {
        synonymButtonAction(sender)
    }
    
    @IBAction func synonymButton3(sender: UIButton) {
        synonymButtonAction(sender)
    }
    
    func synonymButtonAction(sender:UIButton){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.hideContent()
        }
        guard let word = sender.titleLabel?.text else {return}
        getContent(word)
        UIView.animateWithDuration(0.3) { () -> Void in
            self.showContent()
        }
    }
}

