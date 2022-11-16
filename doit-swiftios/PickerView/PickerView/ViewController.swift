//
//  ViewController.swift
//  PickerView
//
//  Created by Wooyoung on 2022/11/12.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 10  // 이미지의 파일명을 저장할 배열의 최대 크기 지정
    let PICKER_VIEW_COLUMN = 2  // 피커 뷰의 열의 개수 지정
    let PICKER_VIEW_HEIGHT: CGFloat = 80    // 피커뷰의 높이 지정
    var imageArray = [UIImage?]()   // MAX_ARRAY_NUM만큼 imageFileName에 있는 이미지를 가져와 UIImage 타입의 상수로 array에 추가할 거임.
    var imageFileName = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg",]
    
    @IBOutlet var pickerImage: UIPickerView!
    // Picer View는 View Controller 아이콘에 끌어 Delegate 사용 설정함.
    // Delegate는 대리자라고도 하며, 특정 객체와 상호 작용할 때 메시지를 넘기면 그 메시지에 대한 책임은 델리게이트로 위임됨.
    // 즉, 사용자가 객체를 터치했을 때 해야 할 일을 델리게이트 메서드에서 구현하고 해당 객체가 터치되었을 때 델리게이트가 호출되어 위임 받은 일을 하게 됨.
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblImageFileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0..<MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }

    // Picker View에게 무엇을 보여주고, 어떻게 동작할지를 설정. Picker View의 동작에 필요한 Delegate Method 추가.
    // Pickver View에게 component의 수를 넘겨줌. Component는 Picker View에 표시되는 열의 개수를 의미함.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // Picker View의 행의 높이를 넘겨줌.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // Picker View에게 component의 행의 개수를 넘겨줌.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // Picker View에게 component의 각 행의 타이틀을 문자열 값으로 넘겨줌. 여기서는 imageFileName에 저장된 파일명을 넘겨줌.
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row]
//    }
    // Picker View에게 component의 각 행의 이미지뷰를 넘겨줌.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row]) // 선택된 행에 해당하는 이미지를 array에서 가져옴
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)   // 이미지뷰의 프레임 크기 설정
        
        return imageView
    }
    
    // Picker View에서 사용자가 룰렛을 선택했을 때 호출됨. 사용자가 선택한 행을 사용하여 원하는 일을 할 수 있음.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        lblImageFileName.text = imageFileName[row]
//        imageView.image = imageArray[row]
        
        if component == 0 {
            lblImageFileName.text = imageFileName[row]
        } else {
            imageView.image = imageArray[row]
        }
    }
}

