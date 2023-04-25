//
//  ProfileVC.swift
//  MoreFirebase
//
//  Created by Josh on 4/14/23.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    private let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.text = firebaseAuth.currentUser?.email
        
    }
    

    @IBAction func logoutPressed(_ sender: Any) {
        
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion:nil)
            performSegue(withIdentifier: "toLoginVC", sender: nil)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }

}
