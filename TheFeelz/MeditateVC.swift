//
//  MeditateVC.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

class MeditateVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeDisplayLabel: UILabel!
    
    var meditationSelection:meditationType = .Time
    enum meditationType {
        case Time
        case Place
    }
    
    //Variables for Sounds Extention
    var meditatePin: AVAudioPlayer?
    var meditatePlayer: AVAudioPlayer?
    
    //Variables for Locations Extention
    let locationManager = CLLocationManager()
    let zoomRadius:CLLocationDistance = 500
    
    //Variables for MapView Extention
    var pinPlaced = false
    var overlayCircle = MKCircle()
    let meditationAlertPoint = MKPointAnnotation()
    
    //Variables for Timer
    var timerStarted = false
    var myTimer = NSTimer()
    var timerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewToLookPretty()
        setupLocationManager()
        setupMapView()
        setupGestureRecongizers()
        setupSoundFiles()
        
        meditationSelectionAnimationSwitch()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViewToLookPretty()
        
    }
    
    @IBAction func startButtonClicked(sender: UIButton) {
        if timerStarted {
            myTimer.invalidate()
            meditatePlayer?.pause()
            sender.setImage(UIImage(named: "metallic-play"), forState: .Normal)
        } else {
            myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimerCount", userInfo: nil, repeats: true)
            meditatePlayer?.play()
            sender.setImage(UIImage(named: "metallic-pause"), forState: .Normal)
        }
        timerStarted = !timerStarted
    }
    
    @IBAction func resetButtonClicked(sender: UIButton) {
        timerCounter = 0
        timeDisplayLabel.text = "0:00"
    }
    
    func updateTimerCount() {
        timerCounter++
        let minutes = Int(timerCounter/60)
        if timerCounter%60 < 10 {
            timeDisplayLabel.text = "\(minutes):0\(timerCounter%60)"
        } else {
            timeDisplayLabel.text = "\(minutes):\(timerCounter%60)"
        }
    }
    
    @IBAction func VolumeSilder(sender: UISlider) {
        adjustVolume(sender.value)
    }
    
    
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 3
        timeView.layer.cornerRadius = 10
        timeView.layer.borderWidth = 3
        placeLabel.textColor = Feelz.sharedInstance.getLinkColour()
        timeLabel.textColor = Feelz.sharedInstance.getLinkColour()
        titleLabel.textColor = Feelz.sharedInstance.getFontColour()
    }

}
