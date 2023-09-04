//
//  UploadViewController.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var expanationText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let imageTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        imageView.addGestureRecognizer(imageTabRecognizer)
    }
    @objc func tapImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true)
    }
    func makeAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    

    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data,metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "")
                }else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            // DataBase
                            let firestoreDataBase = Firestore.firestore()
                            var firestoreReferance : DocumentReference? = nil
                            let firestorePost = ["imageURL : ": imageURL!,"PostedBy : ": Auth.auth().currentUser!.email!, "postComment :" : self.expanationText.text!,"Date : ": FieldValue.serverTimestamp(), "likes :" : 0] as [String : Any]
                            
                            firestoreReferance = firestoreDataBase.collection("Posts").addDocument(data: firestorePost,completion: { error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error" )
                                }else{
                                    self.imageView.image = UIImage(systemName:"plus.app")
                                    self.expanationText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
            
        }
        
    }
    

}
