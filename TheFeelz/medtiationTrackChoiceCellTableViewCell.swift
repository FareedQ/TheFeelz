//
//  medtiationTrackChoiceCellTableViewCell.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-30.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit
import AVFoundation

class MedtiationTrackChoiceCellTableViewCell: UITableViewCell {
    @IBOutlet weak var progressionBar: UIView!
    @IBOutlet weak var choiceTitleLabel: UILabel!

    var meditationTrack: AVAudioPlayer?

    override func awakeFromNib() {
        super.awakeFromNib()
        addGradient(UIColor.grayColor(), colour2: UIColor.whiteColor())
    }
    
    func showProgress(){
        addGradient(Feelz.sharedInstance.getDarkColour(), colour2: Feelz.sharedInstance.getDarkColour())
    }
    
    func hideProgress(){
        addGradient(UIColor.grayColor(), colour2: UIColor.whiteColor())
    }
    
    func addGradient(colour1:UIColor, colour2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [colour1.CGColor, colour2.CGColor]
        progressionBar.layer.insertSublayer(gradient, atIndex: 0)
    }
    
}
