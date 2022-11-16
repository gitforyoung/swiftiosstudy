//
//  ViewController.swift
//  ImageViewer
//
//  Created by Wooyoung on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {
    var numImage : Int = 1
    let maxImage : Int = 6
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBeforeView(_ sender: UIButton) {
        numImage -= 1
        changeImage()
    }
    
    @IBAction func btnNextView(_ sender: UIButton) {
        numImage += 1
        changeImage()
    }
    
    func changeImage(){
        if numImage > maxImage {
            numImage = 1
        } else if numImage < 1 {
            numImage = maxImage
        }
        
        let imageName = String(numImage) + ".png"
        imgView.image = UIImage(named: imageName)
    }
}

