//
//  UploadVC.swift
//  MoreFirebase
//
//  Created by Josh on 4/14/23.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let currentUser = Auth.auth().currentUser
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                
                if error != nil {
                    debugPrint(error?.localizedDescription)
                } else {
                    
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            // Firestore DB
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreRef: DocumentReference? = nil
                            let firestorePost = ["imageUrl": imageUrl!,
                                                 "postedBy": currentUser!.email!,
                                                 "postComment": self.captionTextField.text!,
                                                 "date": FieldValue.serverTimestamp(),
                                                 "likes": 0] as [String : Any]
                            
                            firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    
                                    self.imageView.image = UIImage(systemName: "folder.fill")
                                    self.captionTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                    
                                }
                                
                                
                            }) // end .addDoc
                            
                        }
                    } // end .downloadURL
                } // end else
                
            } // end .putData
            
        } // end data closure
        
    } // end upload
} // end UploadVC
