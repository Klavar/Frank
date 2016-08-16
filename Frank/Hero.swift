//
//  Hero.swift
//  Frank
//
//  Created by Tony Merritt on 16/08/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//


import Foundation
import UIKit

class HeroImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playSnailIdleAnimation()
    }
    
    func playSnailIdleAnimation() {
        
        self.image = UIImage(named: "pinkIdle1.png")
        self.animationImages = nil
        
        //loop for the animation of breathing.
        var imageArray = [UIImage]()
        for x in 1...4 {
            let image = UIImage(named: "pinkIdle\(x).png")
            imageArray.append(image!)
        }
        
        
        
        //Code fo the animation sequence.
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playSnailDeathAnimation() {
        
        self.image = UIImage(named: "pinkDead3.png")
        self.animationImages = nil
        
        //loop for the animation of breathing.
        var imageArray = [UIImage]()
        for x in 1...3 {
            let image = UIImage(named: "pinkDead\(x).png")
            imageArray.append(image!)
        }
        
        
        //Code fo the animation sequence.
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}
