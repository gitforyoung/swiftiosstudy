//
//  ViewController.swift
//  imageView
//
//  Created by Wooyoung on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {
    var isZoom = false //확대 여부를 나타내는 변수
    var imgOn: UIImage? //켜진 전구 이미지가 있는 UIImage 타입의 변수
    var imgOff: UIImage? //꺼진 전구 이미지가 있는 UIImage 타입의 변수
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    // viewDidLoad() : 내가 만든 뷰를 불러왔을 때 호출되는 함수, 부모 클래스인 UIViewController에 선언되어 있음.
    // 뷰를 불러온 후 실행하고자 하는 기능들은 여기에 코드 작성.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        // 32비트나 64비트에서 실수 처리 차이가 발생하는데 CGFloat은 알아서 처리 가능
        // 32비트에서는 Float으로 처리, 64비트에서는 Double로 처리
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isZoom {
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        } else {
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            btnResize.setTitle("축소", for: .normal)
        }
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
}

