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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(!UIApplication.sharedApplication().isRegisteredForRemoteNotifications()){
            alertMessage("This app requires to send notifications to work. You currently have it set off. Please log into your setting and turn it on to recive full capabilites.", thisViewController: self)
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
    
    func checkBackground(){
        view.backgroundColor = Feelz.sharedInstance.getBrightColour()
        leftSideBar.backgroundColor = Feelz.sharedInstance.getBrightColour()
        rightSideBar.backgroundColor = Feelz.sharedInstance.getBrightColour()
    }
}
