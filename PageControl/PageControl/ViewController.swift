//
//  ViewController.swift
//  PageControl
//
//  Created by Wooyoung on 2022/11/13.
//

import UIKit

let images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {
    var pageNumber = 1
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var lblPageNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count    // 페이지 컨트롤의 페이지 수는 이미지 개수
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named: images[0])
        
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
        lblPageNumber.text = String(pageControl.currentPage + 1)
    }
    
}

