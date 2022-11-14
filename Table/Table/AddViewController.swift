//
//  AddViewController.swift
//  Table
//
//  Created by Wooyoung on 2022/11/14.
//

import UIKit

// 피커 뷰와 상호작용하기 위해 피커뷰를 뷰컨에 델리게이트 설정, 피커뷰델리게이트,피커뷰데이터소스 상속
class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let maxArrayNum = 3
    let pickerViewColumn = 1
    let pickerViewHeight: CGFloat = 100
    var iconFiles = ["cart.png", "clock.png", "pencil.png"]
    var iconImageArray = [UIImage?]()
    var selectedIcon: String = "cart.png"

    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var pickerIcon: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 0..<maxArrayNum {
            iconImageArray.append(UIImage(named: iconFiles[i]))
        }
        imgIcon.image = UIImage(named: selectedIcon)
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        // Add 버튼을 누르면 아이템과 이미지 변수에 내용 추가하고 뷰를 pop하여 테이블뷰(메인뷰)로 돌아간다.
        items.append(tfAddItem.text!)
//        itemImageFiles.append("clock.png")
        itemImageFiles.append(selectedIcon)
        tfAddItem.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    
    // 피커 뷰 설정
    // component 개수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewColumn
    }
    
    // 행 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iconFiles.count
    }
    
    // 각 행의 높이 설정
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerViewHeight
    }
    
    // 각 행을 이미지로 표시
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: iconImageArray[row])
        return imageView
    }
    
    // 피커뷰에서 선택되었을 때
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIcon = iconFiles[row]
        imgIcon.image = UIImage(named: selectedIcon)
    }
    //피커뷰 설정 끝
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
