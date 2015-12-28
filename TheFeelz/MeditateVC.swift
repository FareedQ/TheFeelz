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
    let point1 = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewToLookPretty()
        checkBackground()
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkBackground()
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
                mapView.removeAnnotation(point1)
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
                point1.coordinate = touchConvertedToMapPosition
                mapView.addAnnotation(point1)
                
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
        view.backgroundColor = UIColorFromRGB("5E7D41")
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 3
        mapView.layer.borderColor = UIColorFromRGB("1A2129").CGColor
    }
    
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor{
        let scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    func checkBackground(){
        guard let myAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        view.backgroundColor = myAppDelegate.myFeelz.getBrightColour()
    }

}
