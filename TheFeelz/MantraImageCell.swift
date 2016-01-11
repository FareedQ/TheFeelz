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
    }
    
    func animateLike(){
        likeImage.alpha = 1
        likeImage.transform = CGAffineTransformMakeScale(0.3, 0.3)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.likeImage.transform = CGAffineTransformMakeScale(1.3, 1.3)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.likeImage.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.likeImage.alpha = 0
                        })
                })
        }
    }
    
}
