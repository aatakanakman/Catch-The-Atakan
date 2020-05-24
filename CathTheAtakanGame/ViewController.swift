//
//  ViewController.swift
//  CathTheAtakanGame
//
//  Created by Ali Atakan AKMAN on 24.05.2020.
//  Copyright © 2020 Ali Atakan AKMAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    var score  = 0
    var timer = Timer()
    var counter = 0
    var atakanArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    

    @IBOutlet weak var atakan1: UIImageView!
    @IBOutlet weak var atakan2: UIImageView!
    @IBOutlet weak var atakan3: UIImageView!
    @IBOutlet weak var atakan4: UIImageView!
    @IBOutlet weak var atakan5: UIImageView!
    @IBOutlet weak var atakan6: UIImageView!
    @IBOutlet weak var atakan7: UIImageView!
    @IBOutlet weak var atakan8: UIImageView!
    @IBOutlet weak var atakan9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        
        //HighScore Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(newScore)"
            
        }
        
        
        //İmages
        atakan1.isUserInteractionEnabled = true
        atakan2.isUserInteractionEnabled = true
        atakan3.isUserInteractionEnabled = true
        atakan4.isUserInteractionEnabled = true
        atakan5.isUserInteractionEnabled = true
        atakan6.isUserInteractionEnabled = true
        atakan7.isUserInteractionEnabled = true
        atakan8.isUserInteractionEnabled = true
        atakan9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        atakan1.addGestureRecognizer(recognizer1)
        atakan2.addGestureRecognizer(recognizer2)
        atakan3.addGestureRecognizer(recognizer3)
        atakan4.addGestureRecognizer(recognizer4)
        atakan5.addGestureRecognizer(recognizer5)
        atakan6.addGestureRecognizer(recognizer6)
        atakan7.addGestureRecognizer(recognizer7)
        atakan8.addGestureRecognizer(recognizer8)
        atakan9.addGestureRecognizer(recognizer9)
        
        atakanArray = [atakan1, atakan2,atakan3,atakan4,atakan5,atakan6,atakan7,atakan8,atakan9]
        
        
        //Timer
        counter = 10
        timeLabel.text = "Time : \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAtakan), userInfo: nil, repeats: true)
        
        
        hideAtakan()
        
    }
    
    
    @objc func hideAtakan(){
        
            for atakan in atakanArray {
            
            atakan.isHidden = true
        }
        
            let random =  Int(arc4random_uniform(UInt32(atakanArray.count-1)))
        
            atakanArray[random].isHidden = false
    }
    

    
    
    @objc func increaseScore() {
            score += 1
            scoreLabel.text = "Score : \(score)"
    }
    
    
    @objc func countDown() {
        
            counter -= 1
            timeLabel.text = "Time : \(counter)"
        
            if counter == 0 {
                timer.invalidate()
                hideTimer.invalidate()
                
                // HighScore
                
                if self.score > self.highScore {
                    self.highScore = self.score
                    highScoreLabel.text = "HigScore : \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highScore")
                }
                
                
                
         
              //Alert
            
                let alert = UIAlertController(title: "Time's Up", message:"Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                    self.score = 0
                    self.scoreLabel.text = "Score : \(self.score)"
                    self.counter = 10
                    self.timeLabel.text = String(self.counter)
                
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                    
                    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideAtakan), userInfo: nil, repeats: true)
                    }
            
                
                    alert.addAction(okButton)
                    alert.addAction(replayButton)
            
                self.present(alert, animated: true , completion: nil)
            
                for atakan in atakanArray {
                       
                    atakan.isHidden = true
                    }
                }
        
        
    }
    
    
    
    
    
}

