//
//  ViewController.swift
//  Audio
//
//  Created by Wooyoung on 2022/11/14.
//

import UIKit
import AVFoundation

// 오디오 재생을 위한 헤더 파일과 델리게이트가 필요. Import AVFoundation, AVAudioPlayerDelegate 상속
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer! // AVAudioPlayer 인스턴스 변수
    var audioFile: URL! // 재생할 오디오 파일명 변수
    let MAX_VOLUME: Float = 10.0    // 최대 볼륨, 실수형 변수
    var progressTimer: Timer!   // 타이머를 위한 변수
    let timePlayerSelector = #selector(ViewController.updatePlayerTime)
    
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false
    let timeRecordSelector = #selector(ViewController.updateRecordTime)
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    @IBOutlet var swRecordMode: UISwitch!
    
    @IBOutlet var imgState: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode{
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            initRecord()
        }
    }
    
    func selectAudioFile() {
        if !isRecordMode {
            // 녹음 모드가 아닐 때 오디오 파일 불러오기
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        }
        else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        
        }
    }
    
    func initRecord() {
        // 녹음 설정
        // Apple Lossless 포맷, 음질 최대, 비트율은 320000, 오디오 채널 2, 샘플률 44100으로 설정
        let recordSettings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0
        ] as [String : Any]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord \(error)")
        }
        
        audioRecorder.delegate = self
        
        // 볼륨과 시간, 버튼 활성화 상태 변경
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = converNSTimeInterval2String(0)
        lblCurrentTime.text = converNSTimeInterval2String(0)
        setPlayButton(false, pause: false, stop: false)
        
        // 세션 추가, 활성화
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
    func initPlay() {
        // do-try-catch문 사용
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
            // AVAudioPlayer(contentsOf:) throws의 형태로 오류 발생할 수 있는 함수이므로 오류 처리 필요
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        // 슬라이더의 최대값과 현재값 초기화
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0 // 프로그래스뷰의 진행을 0으로 초기화
        
        audioPlayer.delegate = self // audioPlayer의 델리게이트는 self(View Controller)
        audioPlayer.prepareToPlay() // 재생 준비
        audioPlayer.volume = slVolume.value // 볼륨 초기화
        
        lblEndTime.text = converNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = converNSTimeInterval2String(0)
        
        // 재생 준비된 상태이므로 재생 버튼만 활성화
        setPlayButton(true, pause: false, stop: false)
    }
    
    // TimeInterval 값을 받아 문자열로 돌려보내는 함수 만들기
    func converNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)  // time이 초단위 실수값이므로 60으로 나누어 분값 계산
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) // 60으로 나눈 나머지 값
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func setPlayButton(_ play:Bool, pause:Bool, stop:Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()  // 재생 버튼 누르면 오디오 재생
        setPlayButton(false, pause: true, stop: true)
        // 재생하는 동안 현재 시간 라벨이 갱신되어야 하므로 타이머를 이용해 0.1초마다 현재 시간 라벨을 갱신한다.
        imgState.image = UIImage(named: "play.png")
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updatePlayerTime() {
        lblCurrentTime.text = converNSTimeInterval2String(audioPlayer.currentTime)
        // 진행률은 현재시간을 전체 시간으로 나눈값을 사용한다.
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        imgState.image = UIImage(named: "pause.png")
        setPlayButton(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0 // 정지하면 처음부터 재생해야 하므로 시간을 0으로 변경
        lblCurrentTime.text = converNSTimeInterval2String(0)
        progressTimer.invalidate()  // 타이머를 무효화한다.
        imgState.image = UIImage(named: "stop.png")
        setPlayButton(true, pause: false, stop: false)
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    // 오디오 재생이 끝났을 때 함수 정의하기
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButton(true, pause: false, stop: false)
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()  // 재생을 멈춤
            audioPlayer.currentTime = 0
            lblRecordTime!.text = converNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = converNSTimeInterval2String(0)
        }
        
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            imgState.image = UIImage(named: "record.png")
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {
            audioRecorder.stop()
            imgState.image = UIImage(named: "stop.png")
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    @objc func updateRecordTime() {
        lblRecordTime.text = converNSTimeInterval2String(audioRecorder.currentTime)
    }
    
}

