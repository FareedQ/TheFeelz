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
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    var meditationSelection:meditationType = .Time
    enum meditationType {
        case Time
        case Place
    }
    
    //Variables for Sounds Extention
    var meditationTrack: AVAudioPlayer?
    
    //Variables for Locations Extention
    let locationManager = CLLocationManager()
    let zoomRadius:CLLocationDistance = 1000
    
    //Variables for MapView Extention
    var pinPlaced = false
    var overlayCircle = MKCircle()
    let meditationAlertPoint = MKPointAnnotation()
    
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

    @IBAction func musicSwitch(sender: UISwitch){
        if sender.on {
            meditationTrack?.play()
        } else {
            meditationTrack?.pause()
        }
    }
    
    
    
    @IBAction func VolumeSilder(sender: UISlider) {
        adjustVolume(sender.value)
    }
    
    
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBrightColour()
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 3
        timeView.layer.cornerRadius = 10
        timeView.layer.borderWidth = 3
        placeLabel.textColor = UIColor.whiteColor()
        timeLabel.textColor = UIColor.whiteColor()
    }

}
