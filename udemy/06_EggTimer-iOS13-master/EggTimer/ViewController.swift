//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBOutlet var lblText: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func updateCounter() {
        if secondsPassed < totalTime {
            let percentProgress = secondsPassed / totalTime
            progressBar.progress = percentProgress
            secondsPassed += 1
        } else {
            lblText.text = "Done"
            timer.invalidate()
        }
    }
        
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
    }
    
}
