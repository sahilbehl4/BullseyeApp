//
//  ViewController.swift
//  BullsEye
//
//  Created by Sahil Behl on 2018-03-29.
//  Copyright © 2018 Sahil Behl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var targetValue: Int = 0
    var currentValue: Int = 50
    var score: Int = 0
    var round: Int = 1
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueDisplayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNew()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top:0, left: 14, bottom:0, right:14)
        
        let leftTrackImage = UIImage(named: "SliderTrackLeft")
        let leftTrackResizable = leftTrackImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(leftTrackResizable, for: .normal)
        
        let rightTrackImage = UIImage(named: "SliderTrackRight")
        let rightTrackResizable = rightTrackImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(rightTrackResizable, for: .normal)


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels()
    {
        targetValueDisplayLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func showAlert(){
        let title: String
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        round = round + 1
        
        if(difference == 0)
        {
            points = points + 100
            title = "Perfect!"
        }
        else if(difference < 5)
        {
            if(difference == 1)
            {
                points = points + 50
            }
            title = "Almost Had It!"
        }
        else if(difference < 10)
        {
            title = "So close!"
        }
        else
        {
            title = "Not even close!"
        }
        
        score = score + points
        
        let alert = UIAlertController(title: title, message:"Your points are \(points)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style : .default, handler : {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction  func startNew()
    {
        round = 1
        score = 0
        startNewRound()
    }
  
}

