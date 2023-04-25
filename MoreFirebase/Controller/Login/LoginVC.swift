//
//  LoginVC.swift
//  MoreFirebase
//
//  Created by Josh on 4/13/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinningIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        guard let email = emailTextField.text, email.isNotEmpty,
              let password = passwordTextField.text, password.isNotEmpty else {return}
        
        spinningIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
    
            if let error = error {
                self.spinningIndicator.stopAnimating()
                debugPrint(error)
                return
            } else {
                self.spinningIndicator.stopAnimating()
                self.performSegue(withIdentifier: "loginToFeedVC", sender: nil)
            }
        } // end auth
        
        
    }
    
    @IBAction func createNewUserPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateNewUserVC", sender: nil)
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        
    }
    
}
