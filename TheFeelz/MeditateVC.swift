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
    @IBOutlet weak var tableView: UITableView!
    
    enum meditationType {
        case Time
        case Location
    }
    
    var meditationSelection:meditationType = .Time
    
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

    @IBAction func meditationTypeSwitch(sender: AnyObject) {
        guard let switchOutlet = sender as? UISwitch else { return }
        if switchOutlet.on {
            meditationSelection = .Location
        } else {
            meditationSelection = .Time
        }
        meditationSelectionAnimationSwitch()
    }
    

    
    @IBAction func VolumeSilder(sender: UISlider) {
        adjustVolume(sender.value)
    }
    

    


}
