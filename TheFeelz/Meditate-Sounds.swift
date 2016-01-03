//
//  Meditate-AVFoundations.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-28.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import AVFoundation

extension MeditateVC {
    
    func setupSoundFiles(){
        if let tempSound = self.setupAudioPlayerWithFile("Meditate-Pin", type:"mp3") {
            self.meditatePin = tempSound
        }
        if let tempSound = self.setupAudioPlayerWithFile("Meditate-Player", type:"wav") {
            self.meditatePlayer = tempSound
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
    
    func adjustVolume(value:Float){
        meditatePlayer?.volume = value
    }

}
