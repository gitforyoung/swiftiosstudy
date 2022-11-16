//
//  ViewController.swift
//  Alarm
//
//  Created by Wooyoung on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {
    let timeInterval = 1.0
    var alarmTime: String?
    var count = 0
    
    let timeSelector = #selector(ViewController.updateTime)
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    @IBOutlet var lblCounter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblPickerTime.text = "Selected: " + formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm a"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime() {
        lblCounter.text = String(count)
        count += 1
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblCurrentTime.text = "Now: " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm a"
        let currentTime = formatter.string(from: date as Date)
        if currentTime == alarmTime {
            view.backgroundColor = UIColor.red
        } else {
            view.backgroundColor = UIColor.white
        }
    }
}

