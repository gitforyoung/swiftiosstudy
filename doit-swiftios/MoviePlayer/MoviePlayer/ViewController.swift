//
//  ViewController.swift
//  MoviePlayer
//
//  Created by Wooyoung on 2022/11/15.
//

import UIKit
import AVKit    // 비디오 관련

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
//        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
//        let url = NSURL(fileURLWithPath:  filePath!)
        let url = Bundle.main.url(forResource: "FastTyping", withExtension: "mp4")!
        playVideo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        playVideo(url: url)
    }
    
    private func playVideo(url: URL) {
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: url)
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

