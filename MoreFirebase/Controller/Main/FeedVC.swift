//
//  FeedVC.swift
//  MoreFirebase
//
//  Created by Josh on 4/14/23.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
    
    private var postArray: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        getDataFromFirestore()
        
    }
    
    func getDataFromFirestore() {
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts")
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                debugPrint(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true  {
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        var postInformation = Post(
                            useremail: document.get("postedBy") as! String,
                            timestamp: (document.get("date") as? Timestamp)?.dateValue() ?? Date(),
                            imagePost: document.get("imageUrl") as! String,
                            showText: document.get("postComment") as! String,
                            numLikes: document.get("likes") as! Int,
                            documentID: document.documentID as! String
                            )
                        
                        self.postArray.append(postInformation)
                        
                    }
                    
                    self.feedTableView.reloadData()
                }
                
            }
        }
        
    }// end getDataFromFirestore()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell {
            let post = postArray[indexPath.item]
            cell.configureCell(post: post)
            
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}
