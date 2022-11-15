//
//  ViewController.swift
//  CameraPhtoLibrary
//
//  Created by Wooyoung on 2022/11/15.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL!
    var flagImageSave = false
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // 카메라 사용 가능한 경우
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        } else {
            myAlert("Photo album inaccessble", message: "Application cannot access the photo album.")
        }
    }
    
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.movie"]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.movie"]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            myAlert("Photo album inaccessble", message: "Application cannot access the photo album.")
        }
    }
    
    // 사용자가 촬영하지 않고 취소하거나 선택하지 않고 취소한 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    // 경고 표시용 메서드 만들기
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    // 사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출되는 메서드 구현
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString  // 미디어 종류 확인
        
        // NSString 타입을 사용해야 isEqual 사용 가능
        if mediaType.isEqual(to: "public.image") {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            imgView.image = captureImage
        } else if mediaType.isEqual(to: "public.movie") {
            if flagImageSave {
                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        self.dismiss(animated: true)
    }
}

