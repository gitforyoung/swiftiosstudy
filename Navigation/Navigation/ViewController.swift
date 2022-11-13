//
//  ViewController.swift
//  Navigation
//
//  Created by Wooyoung on 2022/11/13.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    var isOn = true
    var isZoom = false
    var zoomed = false
    let scale = 2.0
    
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = imgOn
    }

    // segue가 viewcontroller로 전환되기 직전 호출되는 함수. 데이터 전달을 위해 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" {
            editViewController.textWayValue = "segue : use button"
        }
        else if segue.identifier == "editBarButton" {
            editViewController.textWayValue = "segue : use Bar button"
        }
        editViewController.textMessage = txtMessage.text!   // 메인화면에서 입력한 것을 수정화면에서 텍스트 변경
        editViewController.isOn = isOn
        editViewController.isZoom = isZoom
        editViewController.delegate = self  // delegate의 위임자 지정 = 메인화면
    }
    
    // EditDelegate 프로토콜을 상속 받았으므로 아래에서 실질적인 내용을 작성
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message
    }
    
    func didImageOnOffDone(isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        }
        else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didImageSizeDone(isZoom: Bool) {
        var newWidth: CGFloat, newHeight: CGFloat
        if isZoom {
            if zoomed {
                // 확대하는 것으로 선택됨, 이미 확대되어 있음
            }
            else {
                // 확대하는 것으로 선택됨, 아직 확대 안 됨
                newWidth = imgView.frame.width * scale
                newHeight = imgView.frame.height * scale
                self.isZoom = true
                self.zoomed = true
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
            
        }
        else {
            if zoomed {
                // 축소하는 것으로 선택됨, 이미 확대됨
                newWidth = imgView.frame.width / scale
                newHeight = imgView.frame.height / scale
                self.isZoom = false
                self.zoomed = false
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
            else {
                // 축소하는 것으로 선택됨, 아직 확대 안 됨
            }
        }

    }

}

