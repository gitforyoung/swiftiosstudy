//
//  ViewController.swift
//  SwipeGesture
//
//  Created by Wooyoung on 2022/11/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgViewUp: UIImageView!
    @IBOutlet var imgViewLeft: UIImageView!
    @IBOutlet var imgViewRight: UIImageView!
    @IBOutlet var imgViewDown: UIImageView!
    
    
    // 방향별로 검은색과 빨간색 이미지를 저장하기 위한 배열 선언
    var imgUp = [UIImage]()
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    var imgDown = [UIImage]()
    
    
    // 멀티 터치
    let numberOfTouchs = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgUp.append(UIImage(named: "arrow-up-black.png")!)
        imgUp.append(UIImage(named: "arrow-up-red.png")!)
        imgUp.append(UIImage(named: "arrow-up-green.png")!)
        imgLeft.append(UIImage(named: "arrow-left-black.png")!)
        imgLeft.append(UIImage(named: "arrow-left-red.png")!)
        imgLeft.append(UIImage(named: "arrow-left-green.png")!)
        imgRight.append(UIImage(named: "arrow-right-black.png")!)
        imgRight.append(UIImage(named: "arrow-right-red.png")!)
        imgRight.append(UIImage(named: "arrow-right-green.png")!)
        imgDown.append(UIImage(named: "arrow-down-black.png")!)
        imgDown.append(UIImage(named: "arrow-down-red.png")!)
        imgDown.append(UIImage(named: "arrow-down-green.png")!)
        
        imgViewUp.image = imgUp[0]
        imgViewLeft.image = imgLeft[0]
        imgViewRight.image = imgRight[0]
        imgViewDown.image = imgDown[0]
        
        // 스와이프 제스쳐는 UISwipeGestureRecognizer 클래스에 의해 인식됨.
        // 액션 인수는 스와이프 제스쳐를 행했을 때 실행할 메서드를 의미함. 셀렉터를 사용.
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        // 해당 클래스 상수의 direction 속성에 원하는 방향을 설정
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        // 멀티 터치를 등록하기 위해서는 numberOfTouchesRequired 속성 사용
//        swipeUp.numberOfTouchesRequired = numberOfTouchs
        // 뷰 객체의 addGestureRecognizer 메서드를 사용해 원하는 방향의 스와이프 제스쳐를 동록하여 인식하게 됨.
        self.view.addGestureRecognizer(swipeUp)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        swipeLeft.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        swipeRight.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
//        swipeDown.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeDown)
        
        // 멀티 터치에 대한 제스쳐도 추가하여 등록
        let swipeUpMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeUpMulti.direction = UISwipeGestureRecognizer.Direction.up
        swipeUpMulti.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeUpMulti)
        
        let swipeLeftMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeLeftMulti.direction = UISwipeGestureRecognizer.Direction.left
        swipeLeftMulti.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeLeftMulti)
        
        let swipeRightMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeRightMulti.direction = UISwipeGestureRecognizer.Direction.right
        swipeRightMulti.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeRightMulti)
        
        let swipeDownMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeDownMulti.direction = UISwipeGestureRecognizer.Direction.down
        swipeDownMulti.numberOfTouchesRequired = numberOfTouchs
        self.view.addGestureRecognizer(swipeDownMulti)

    }

    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            // swipe 제스쳐가 있다면
            
            // 일단 모두 검정으로 초기화
            imgViewUp.image = imgUp[0]
            imgViewLeft.image = imgLeft[0]
            imgViewRight.image = imgRight[0]
            imgViewDown.image = imgDown[0]
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                imgViewUp.image = imgUp[1]
            case UISwipeGestureRecognizer.Direction.left:
                imgViewLeft.image = imgLeft[1]
            case UISwipeGestureRecognizer.Direction.right:
                imgViewRight.image = imgRight[1]
            case UISwipeGestureRecognizer.Direction.down:
                imgViewDown.image = imgDown[1]
            default:
                break
            }
        }
    }
    
    @objc func respondToSwipeGestureMulti(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            // swipe 제스쳐가 있다면
            
            // 일단 모두 검정으로 초기화
            imgViewUp.image = imgUp[0]
            imgViewLeft.image = imgLeft[0]
            imgViewRight.image = imgRight[0]
            imgViewDown.image = imgDown[0]
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                imgViewUp.image = imgUp[2]
            case UISwipeGestureRecognizer.Direction.left:
                imgViewLeft.image = imgLeft[2]
            case UISwipeGestureRecognizer.Direction.right:
                imgViewRight.image = imgRight[2]
            case UISwipeGestureRecognizer.Direction.down:
                imgViewDown.image = imgDown[2]
            default:
                break
            }
        }
    }

}

