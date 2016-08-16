//
//  ViewController.swift
//  Frank
//
//  Created by Tony Merritt on 11/08/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var bgOneImage: UIImageView!
    @IBOutlet weak var bgTwoImage: UIImageView!

    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var foodImage: DragImage!
    @IBOutlet weak var flowerImage: DragImage!
    @IBOutlet weak var monsterImage: MonsterImage!
    @IBOutlet weak var heroImage: HeroImage!
    @IBOutlet weak var livesBox: UIImageView!
    @IBOutlet weak var peneltyOneImage: UIImageView!
    @IBOutlet weak var peneltyTwoImage: UIImageView!
    @IBOutlet weak var peneltyThreeImage: UIImageView!
    
    @IBOutlet weak var restartButton: UIButton!

    @IBOutlet weak var rockImage: UIButton!
    @IBOutlet weak var snailImage: UIButton!
    @IBOutlet weak var pickImage: UILabel!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENELTIES = 3
    
    var x = 0
    var penelties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0

    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxFlower: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        peneltyOneImage.alpha = DIM_ALPHA
        peneltyTwoImage.alpha = DIM_ALPHA
        peneltyThreeImage.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxFlower = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("club", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxSkull.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxFlower.prepareToPlay()
            
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
        
    }
    @IBAction func onRestartPressed(sender: AnyObject) {
        player()
        viewDidLoad()
        
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        flowerImage.alpha = DIM_ALPHA
        flowerImage.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        }else if currentItem == 1 {
            sfxBite.play()
        }else {
            sfxFlower.play()
        }
        
    }
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
        
    }
    
    func changeGameState() {
        
        if !monsterHappy {
        
        penelties += 1
            
            sfxSkull.play()
        
        if penelties == 1 {
            peneltyOneImage.alpha = OPAQUE
            peneltyTwoImage.alpha = DIM_ALPHA
        }else if penelties == 2 {
            peneltyTwoImage.alpha = OPAQUE
            peneltyThreeImage.alpha = DIM_ALPHA
        }else if penelties >= 3 {
            peneltyThreeImage.alpha = OPAQUE
        }else {
            peneltyOneImage.alpha = DIM_ALPHA
            peneltyTwoImage.alpha = DIM_ALPHA
            peneltyThreeImage.alpha = DIM_ALPHA
        }
        
        if penelties >= MAX_PENELTIES {
            gameOver()
        }
    }
        
        let rand = arc4random_uniform(3)
        
        if rand == 0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            flowerImage.alpha = DIM_ALPHA
            flowerImage.userInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        }else  if rand == 1 {
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            flowerImage.alpha = DIM_ALPHA
            flowerImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
        }else {
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha =   DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            flowerImage.alpha = OPAQUE
            flowerImage.userInteractionEnabled = true
        }
        
        
        currentItem = rand
        monsterHappy = false
    }

        
        func gameOver() {
  
            timer.invalidate()
            
        if x == 0 {
            monsterImage.playDeathAnimation()
            sfxDeath.play()
            restartButton.hidden = false
            heartImage.hidden = true
            foodImage.hidden = true
            flowerImage.hidden = true
        
            
        }else {
            heroImage.playSnailDeathAnimation()
            sfxDeath.play()
            restartButton.hidden = false
            heartImage.hidden = true
            foodImage.hidden = true
            flowerImage.hidden = true
           
    }
    
    }
    
    func player() {

        restartButton.hidden = true
        penelties = 0
        heartImage.hidden = false
        foodImage.hidden = false
        flowerImage.hidden = false
        livesBox.hidden = false
        peneltyOneImage.hidden = false
        peneltyTwoImage.hidden = false
        peneltyThreeImage.hidden = false
        
        if x == 0 {

      
        monsterImage.hidden = false
        monsterImage.playIdleAnimation()
        monsterHappy = false
            
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        flowerImage.dropTarget = monsterImage
        }else if x == 1 {
          
            heroImage.hidden = false
            heroImage.playSnailIdleAnimation()
            monsterHappy = false
            
            foodImage.dropTarget = heroImage
            heartImage.dropTarget = heroImage
            flowerImage.dropTarget = heroImage
        }
    }
    @IBAction func onRockPressed(sender: AnyObject) {
        hideStartImages()
        bgOneImage.hidden = false
        bgTwoImage.hidden = true
        x = 0
        viewDidLoad()
        player()
    }
    @IBAction func onSnailPressed(sender: AnyObject) {
        hideStartImages()
        bgOneImage.hidden = true
        bgTwoImage.hidden = false
        x = 1
        player()
        viewDidLoad()
    }
    
    func hideStartImages() {
    rockImage.hidden = true
    snailImage.hidden = true
    pickImage.hidden = true
    levelImage.hidden = true
   
        
    
    }
   
    
}