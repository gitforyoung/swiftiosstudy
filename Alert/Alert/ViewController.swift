//
//  ViewController.swift
//  Alert
//
//  Created by Wooyoung on 2022/11/12.
//

import UIKit

class ViewController: UIViewController {
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    var isLampOn = true
    
    @IBOutlet var lampImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lampImg.image = imgOn
    }

    @IBAction func btnLampON(_ sender: UIButton) {
        if isLampOn == true {
            // 켜져 있으면 켜져 있다고 alert 실행
            // UIAlertController 생성, title/message/preferredStytle 설정
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 On 상태임.", preferredStyle: UIAlertController.Style.actionSheet)
            // UIAlertAction 생성, title, style 설정, 특별한 동작을 하지 않는 경우 handler는 nil
            let onAction = UIAlertAction(title: "네", style: UIAlertAction.Style.cancel, handler: nil)
            // 생성된 alert에 onAction을 추가함
            lampOnAlert.addAction(onAction)
            //
            present(lampOnAlert, animated: true, completion: nil)
        } else {
            // 꺼져 있다고 alert 실행
            lampImg.image = imgOn
            isLampOn = true
        }
    }
    
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn {
            // 켜져 있으면 끌지 묻는 alert 실행
            let lampOffAlert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.actionSheet)
            // handler에 closure 사용. Closure는 함수 이름을 선언하지 않고 바로 함수 몸체만 만들어 사용하는 일회용 함수로, 익명 함수라고도 함. (매개변수)->(반환타입) in 실행 구문
            let offAction = UIAlertAction(title: "네", style: UIAlertAction.Style.destructive, handler: {action in self.lampImg.image = self.imgOff
                self.isLampOn = false
            })
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default)
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            present(lampOffAlert, animated: true)
        }
    }
    
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프 제거", message: "램프를 제거하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let offAction = UIAlertAction(title: "아니오, 끕니다", style: UIAlertAction.Style.default, handler: {action in self.lampImg.image = self.imgOff
            self.isLampOn = false
        })
        let onAction = UIAlertAction(title: "아니오, 켭니다", style: UIAlertAction.Style.default, handler: {action in self.lampImg.image = self.imgOn
            self.isLampOn = true
        })
        let removeAction = UIAlertAction(title: "네, 제거합니다", style: UIAlertAction.Style.default, handler: {action in self.lampImg.image = self.imgRemove
            self.isLampOn = false
        })
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        present(lampRemoveAlert, animated: false)
    }
}

