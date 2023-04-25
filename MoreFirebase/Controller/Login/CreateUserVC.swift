//
//  CreateUserVC.swift
//  MoreFirebase
//
//  Created by Josh on 4/13/23.
//

import UIKit
import FirebaseAuth

class CreateUserVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let passText = passwordTextField.text else {return}
        
        if passText.isEmpty {
            confirmPasswordTextField.text = ""
        }
        
        if passwordTextField.text == confirmPasswordTextField.text {
            confirmPasswordTextField.backgroundColor = UIColor.green
        } else {
            confirmPasswordTextField.backgroundColor = UIColor.red
        }
        
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, email.isNotEmpty,
              let username = usernameTextField.text, username.isNotEmpty,
              let password = passwordTextField.text, password.isNotEmpty else { return }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                debugPrint(error)
                return
            } else {
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "registerToFeedVC", sender: nil)
            }
        }
    } // signUpPressed()
    
    
} // end CreateUserVC
