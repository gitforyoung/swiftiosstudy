//
//  ViewController.swift
//  DatePicker
//
//  Created by Wooyoung on 2022/11/11.
//

import UIKit

class DateViewController: UIViewController {
    // Selector 생성
    let timeSelecter: Selector = #selector(DateViewController.updateTime)
    let interval = 1.0
    var count = 0
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // timeInterval 타이머 간격, target 동작될 view, selector 타이머가 구동될 떄 실행할 함수, userInfo 사용자 정보, repeats 반복 여부
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelecter, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        // 전달 받은 UIDatePicker 타입의 인수인 sender를 받아 저장
        let datePickerView = sender
        
        // 날짜를 출력하기 위해 DateFormatter 클래스 상수 선언
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblPickerTime.text = "선택 시간: " + formatter.string(from: datePickerView.date)
    }
    
    // 타이머가 동작할 때 실행할 함수 추가.
    // #selector()의 인자로 사용될 메서드 선언 시 Object-C와의 호환성을 위해 함수 앞에 @objc 키워드 붙힘
    @objc func updateTime() {
//        lblCurrentTime.text = String(count)
//        count += 1
        // 현재 시간 가져오기
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date)
        
    }
}

