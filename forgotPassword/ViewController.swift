//
//  ViewController.swift
//  fileUpload2
//
//  Created by raSe on 13.11.2017.
//  Copyright © 2017 raSe. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase
import FirebaseStorage



class ViewController: UIViewController {
    
    @IBOutlet weak var progress: UIProgressView!
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        
     
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadImageToFirebaseStorage(data: NSData)  {
        let storageRef = Storage.storage().reference(withPath: "mypics/demoPic.jpg")
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = ("image/jpeg")
        let uploadTask = storageRef.putData(data as Data, metadata: uploadMetadata) { (metadata, error)  in
            if (error != nil){
                
                print("bir hata aldım! \(String(describing: error?.localizedDescription))")
            }
            else{
                print("yükleme tamamlandı! \(String(describing: metadata))")
            }
        }
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            guard let progress = snapshot.progress else {return}
            strongSelf.progressView.progress = Float(progress.fractionCompleted)
        }
    }
    func uploadImageToFirebaseStorage(url: NSURL)  {
        _ = Storage.storage().reference(withPath: "myMovies/testMovie.Mov")

        
    }
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel( _ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        return
    }
}
func didReceiveMemoryWarning() {
 }


