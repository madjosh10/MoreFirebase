//
//  FeedCell.swift
//  MoreFirebase
//
//  Created by Josh on 4/23/23.
//

import UIKit
import SDWebImage
import FirebaseFirestore

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImagePosted: UIImageView!
    @IBOutlet weak var imageCaption: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private var documentID : String!
    private let firestore = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        userEmailLabel.text = post.useremail
        userImagePosted.sd_setImage(with: URL(string: post.imagePost))
        imageCaption.text = post.showText
        likeLabel.text = String(post.numLikes)
        documentID = post.documentID
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        let firestoreDatabase = firestore
        guard let liked = Int(likeLabel.text!) else { return  }
        
        if likeButton.titleLabel?.text == "Like" {
            firestoreDatabase.collection("Posts").document(documentID).updateData(["likes": liked + 1])
            likeButton.setTitle("Unlike", for: .normal)
            
        } else {
            firestoreDatabase.collection("Posts").document(documentID).updateData(["likes": liked - 1])
            likeButton.setTitle("Like", for: .normal)
        }
        
        
    }
    
}
