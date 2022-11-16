//
//  EditViewController.swift
//  Navigation
//
//  Created by Wooyoung on 2022/11/13.
//

import UIKit

// 포로토콜이란 특정 객체가 갖추어야할 기능이나 속성에 대한 설계도라고 할 수 있음.
// 단순한 선언 형태만 앚으며 실질 내용은 프로토콜을 이용하는 객체에서 정의함.
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(isOn: Bool)
    func didImageSizeDone(isZoom: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate? // delegate 변수 생성
    var isOn = false
    var isZoom = false

    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnSize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblWay.text = textWayValue
        txtMessage.text = textMessage
        
        swIsOn.isOn = isOn
        if !isZoom {
            btnSize.setTitle("확대", for: .normal)
        }
        else {
            btnSize.setTitle("축소", for: .normal)
        }
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txtMessage.text!)
            delegate?.didImageOnOffDone(isOn: isOn)
            delegate?.didImageSizeDone(isZoom: isZoom)
        }
        
        // 뷰를 전환하기 위해 segue를 추가할 때 acion segue를 show 형태로 했기 때문에 돌아갈 때는 pop의 형태로 함
        navigationController?.popViewController(animated: true)
    }
    
    // 메인화면의 전구 이미지 제어
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        // 스위치의 상태를 확인하여 isOn 변수에 값 저장
        if sender.isOn {
            isOn = true
        }
        else{
            isOn = false
        }
            
    }
    
    @IBAction func btnChangeSize(_ sender: UIButton) {
        if isZoom {
            btnSize.setTitle("확대", for: .normal)
            isZoom = false
        }
        else {
            btnSize.setTitle("축소", for: .normal)
            isZoom = true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
