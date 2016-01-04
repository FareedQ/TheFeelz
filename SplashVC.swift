//
//  myViewController.swift
//  ChoosingEmotions
//
//  Created by FareedQ on 2015-12-04.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    weak var myCarouselSubVC:CarouselSubVC!
    
    @IBOutlet weak var rightSideBar: UIView!
    @IBOutlet weak var leftSideBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewToLookPretty()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(UIApplication.sharedApplication().currentUserNotificationSettings()?.types.rawValue == 0){
            alertMessage("This app requires notifications to be allowed to fully function properly. Please log into your setting and turn on notification for this app to recive its full capabilites.", thisViewController: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //wire the two view controllers together
        if segue.identifier == "SplashToCarousel" {
            guard let tempVC = segue.destinationViewController as? CarouselSubVC else {return}
            myCarouselSubVC = tempVC
            myCarouselSubVC.mySplashVC = self
        }
    }
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBrightColour()
        leftSideBar.backgroundColor = Feelz.sharedInstance.getBrightColour()
        rightSideBar.backgroundColor = Feelz.sharedInstance.getBrightColour()
    }
}
