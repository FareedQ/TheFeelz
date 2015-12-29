//
//  Meditate-Guestures.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-28.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit
import MapKit

extension MeditateVC {

    func setupGestureRecongizers(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(gestureRecognizer)
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
    
}
