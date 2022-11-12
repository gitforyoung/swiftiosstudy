//
//  ViewController.swift
//  AlarmClock
//
//  Created by Wooyoung on 2022/11/12.
//

import UIKit

class ViewController: UIViewController {
    let timeInterval = 1.0
    let timeSelector: Selector = #selector(ViewController.updateTime)
    var alarmTime: String?
    var alertFlag: Bool = false
    
    @IBOutlet var currentTime: UILabel!
    @IBOutlet var selectedTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        selectedTime.text = formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm a"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime(){
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        currentTime.text = formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm a"
        let nowTime = formatter.string(from: date as Date)
        if alarmTime == nowTime {
            if !alertFlag{
                let alarmAlert = UIAlertController(title: "알림", message: "설정된 시간입니다.", preferredStyle: UIAlertController.Style.alert)
                let onAlert = UIAlertAction(title: "네", style: UIAlertAction.Style.default)
                alarmAlert.addAction(onAlert)
                present(alarmAlert, animated: true)
                alertFlag = true
            }
        }
        else {
            alertFlag = false
        }
    }
}

