//
//  Post.swift
//  MoreFirebase
//
//  Created by Josh on 4/19/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

class Post {
    
    private(set) var useremail: String!
    private(set) var dateEvent: Date!
    private var timestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: dateEvent)
    }
    private(set) var imagePost: String!
    private(set) var showText: String!
    private(set) var numLikes: Int!
    private(set) var documentID: String!
    
    init(useremail: String, timestamp: Date, imagePost: String, showText: String, numLikes: Int, documentID: String) {
        self.useremail = useremail
        self.imagePost = imagePost
        self.dateEvent = timestamp
        self.showText = showText
        self.numLikes = numLikes
        self.documentID = documentID
        
    }
}
