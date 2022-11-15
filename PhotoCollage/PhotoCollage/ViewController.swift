//
//  ViewController.swift
//  PhotoCollage
//
//  Created by Wooyoung on 2022/11/15.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    @IBOutlet var btnCapture: UIButton!
    @IBOutlet var btnLoad: UIButton!
    
    
    let imagePicker = UIImagePickerController()
    var flagImageSave = false
    var numImage = 0
    var captureImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnCapturePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            myAlert(title: "Camera inaccessible", message: "Cannot access camera")
        }
    }
    
    @IBAction func btnLoadPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        } else {
            myAlert(title: "Photo album inaccessible", message: "Cannot access album")
        }
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        numImage = 0
        btnCapture.isEnabled = true
        btnLoad.isEnabled = true
        imgView1.image = nil
        imgView2.image = nil
        imgView3.image = nil
    }
    
    
    
    func myAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        numImage += 1
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if flagImageSave {
            UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
        }
        if numImage == 1 {
            imgView1.image = captureImage
            
        }else if numImage == 2 {
            imgView2.image = captureImage
            
        }else if numImage == 3 {
            imgView3.image = captureImage
            btnCapture.isEnabled = false
            btnLoad.isEnabled = false
        }
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}

