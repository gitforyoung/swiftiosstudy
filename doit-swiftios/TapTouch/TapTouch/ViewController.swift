//
//  ViewController.swift
//  TapTouch
//
//  Created by Wooyoung on 2022/11/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 터치 이벤트 재정의
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch   // 현재 발생한 터치 이벤트 가져오기
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)   // 첫 번째 터치에서 탭의 개수
        txtTouchCount.text = String(touches.count)  // Touches 세트 안에 포함된 터치 개수 출력
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        <#code#>
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        <#code#>
//    }
}

