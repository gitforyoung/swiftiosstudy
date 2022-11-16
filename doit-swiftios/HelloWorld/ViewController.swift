//
//  ViewController.swift
//  HelloWorld
//
//  Created by Wooyoung on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {
    // @IBOutlet: Interface Builder Outlet
    @IBOutlet var lblHello: UILabel! //출력 레이블용 아웃렛 변수
    @IBOutlet var txtName: UITextField! //이름 입력용 아웃렛 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // @IBAction: Interface Builder Action
    // _sender: UIButton: 액션 함수가 실행되도록 이벤트를 보내는 객체, UIButton 클래스 타입을 선택함.
    @IBAction func btnSend(_ sender: UIButton) {
        // txtName 변수의 텍스트를 가져와 다른 문자열과 결합하여 lblHello의 텍스트에 넣음
        lblHello.text = "Hello, " + txtName.text!
        // ! 옵셔널 변수의 강제 언래핑
    }
}

