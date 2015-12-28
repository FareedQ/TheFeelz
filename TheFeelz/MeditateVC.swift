//
//  MeditateVC.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
import MapKit

class MeditateVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var meditationTrack: AVAudioPlayer?
    
    let locationManager = CLLocationManager()
    let zoomRadius:CLLocationDistance = 1000
    
    var overlayCircle = MKCircle()
    var pinPlaced = false
    let meditationAlertPoint = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewToLookPretty()
        
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(gestureRecognizer)
        if let tempSound = self.setupAudioPlayerWithFile("Meditation", type:"mp3") {
            self.meditationTrack = tempSound
        }
        
        let initialLocation = CLLocation(latitude: 43.6472850, longitude: -79.3870760)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, zoomRadius, zoomRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        alertMessage("The map did not properly load. You may not be connected to the internet. The app will still function but not at full capacity.", thisViewController: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupViewToLookPretty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func meditationTypeSwitch(sender: AnyObject) {
        guard let switchOutlet = sender as? UISwitch else { return }
        if (switchOutlet.on) {
            mapView.hidden = true
        } else {
            mapView.hidden = false
        }
        
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        let touchPosition = sender.locationInView(view)
        
        if mapView.frame.contains(touchPosition) {
            if pinPlaced {
                //removed annotation pin and circle
                mapView.removeAnnotation(meditationAlertPoint)
                mapView.removeOverlay(overlayCircle)
                
                //Reset Music
                meditationTrack?.pause()
                meditationTrack?.stop()
                meditationTrack?.currentTime = 0
                
                //set flag
                pinPlaced = false
            } else {
                let touchConvertedToMapPosition = mapView.convertPoint(touchPosition, toCoordinateFromView: view)
                
                //add annotation pin
                meditationAlertPoint.coordinate = touchConvertedToMapPosition
                mapView.addAnnotation(meditationAlertPoint)
                
                //add circle
                overlayCircle = MKCircle(centerCoordinate: touchConvertedToMapPosition, radius: 25 as CLLocationDistance)
                mapView.addOverlay(overlayCircle)
                
                //Begin meditation music
                meditationTrack?.play()
                
                //set flag
                pinPlaced = true
            }
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }
        return MKOverlayRenderer()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBrightColour()
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 3
        view.backgroundColor = Feelz.sharedInstance.getDarkColour()
    }

}
