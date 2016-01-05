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
            removePin()
        }
        
        if placeLabel.frame.contains(touchPosition){
            meditationSelection = .Place
            meditationSelectionAnimationSwitch()
            gongsSwitch.on = false
            meditatePlayer?.pause()
        }
        
        if mapView.frame.contains(touchPosition) && meditationSelection == .Place {
            if pinPlaced {
                removePin()
            } else {
                addPin(touchPosition)
            }
        }
    }
    
    func removePin(){
        //removed annotation pin and circle
        mapView.removeAnnotation(meditationAlertPoint)
        mapView.removeOverlay(overlayCircle)
        
        //Reset Music
        meditatePin?.pause()
        meditatePin?.stop()
        meditatePin?.currentTime = 0
        
        //set flag
        pinPlaced = false
    }
    
    func addPin(touchPosition:CGPoint){
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
