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
        
        if timeLabel.frame.contains(touchPosition){
            meditationSelection = .Time
            meditationSelectionAnimationSwitch()
        }
        
        if placeLabel.frame.contains(touchPosition){
            meditationSelection = .Place
            meditationSelectionAnimationSwitch()
        }
        
        if mapView.frame.contains(touchPosition) && meditationSelection == .Place {
            if pinPlaced {
                //removed annotation pin and circle
                mapView.removeAnnotation(meditationAlertPoint)
                mapView.removeOverlay(overlayCircle)
                
                //Reset Music
                meditatePin?.pause()
                meditatePin?.stop()
                meditatePin?.currentTime = 0
                
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
                meditatePin?.play()
                
                //set flag
                pinPlaced = true
            }
        }
    }
    
    func meditationSelectionAnimationSwitch(){
        switch meditationSelection {
        case .Place:
            mapView.hidden = false
            timeView.hidden = true
            break
        case .Time:
            mapView.hidden = true
            timeView.hidden = false
            break
        }
    }
    
}
