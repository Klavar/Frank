//
//  MonsterImage.swift
//  Frank
//
//  Created by Tony Merritt on 12/08/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    playIdleAnimation()
    }

    func playIdleAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        //loop for the animation of breathing.
        var imageArray = [UIImage]()
        for x in 1...4 {
            let image = UIImage(named: "idle\(x).png")
            imageArray.append(image!)
        }
        
        
        
        //Code fo the animation sequence.
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
       
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        //loop for the animation of breathing.
        var imageArray = [UIImage]()
        for x in 1...5 {
            let image = UIImage(named: "dead\(x).png")
            imageArray.append(image!)
        }
        
        
        //Code fo the animation sequence.
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}