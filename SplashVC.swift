//
//  myViewController.swift
//  ChoosingEmotions
//
//  Created by FareedQ on 2015-12-04.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class splashViewController: UIViewController {
    
    weak var myCarouselViewController:carouselViewController!
    
    @IBOutlet weak var rightSideBar: UIView!
    @IBOutlet weak var leftSideBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //wire the two view controllers together
        if segue.identifier == "SplashToCarousel" {
            guard let tempVC = segue.destinationViewController as? carouselViewController else {return}
            myCarouselViewController = tempVC
            myCarouselViewController.mySplashViewController = self
        }
    }
    
    func checkBackground(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        view.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
        leftSideBar.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
        rightSideBar.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
    }
}
