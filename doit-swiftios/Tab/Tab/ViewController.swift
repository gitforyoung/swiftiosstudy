//
//  ViewController.swift
//  Tab
//
//  Created by Wooyoung on 2022/11/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnMovewImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func btnMovDatePickerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
}

