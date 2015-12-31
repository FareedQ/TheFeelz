//
//  MantraCollectionViewCell.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class MantraImageCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    
    override func awakeFromNib() {
        likeImage.alpha = 0
        likeImage.transform = CGAffineTransformMakeScale(0.3, 0.3)
    }
    
    func showImage(){
        likeImage.alpha = 1
        layoutIfNeeded()
    }
    
}
