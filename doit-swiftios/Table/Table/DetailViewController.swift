//
//  DetailViewController.swift
//  Table
//
//  Created by Wooyoung on 2022/11/14.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveItem = ""    // 메인뷰에서 받을 텍스트를 위한 변수

    @IBOutlet var lblItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
    }
    
    func receiveItem(_ item: String) {
        receiveItem = item
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
