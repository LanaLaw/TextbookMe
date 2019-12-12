//
//  Textbook.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/6/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import Foundation
import Firebase



class Textbook: NSObject {
    

    var title: String 
    var cost: Int
    var author: String
    var name: String
    var email: String
    var phoneNumber: String
    var postingUserId: String
    var postingUserName: String
    var documentId: String
    
    

    var dictionary: [String: Any] {
        return ["title" : title,
                "cost" : cost,
                "author": author,
                "name" : name,
                "email" : email,
                "phoneNumber" : phoneNumber,
                "postingUserId" : postingUserId,
                "postingUserName" : postingUserName,
        ]
    }
    
 
    init(title: String,
         cost: Int,
        author: String,
        name: String,
        email: String,
        phoneNumber: String,
        postingUserId: String,
        postingUserName: String,
        documentId: String
    ) {
        self.title = title
        self.cost = cost
        self.author = author
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.postingUserId = postingUserId
        self.postingUserName = postingUserName
        self.documentId = documentId
    }
    
    
    convenience override init () {
        self.init(
            title: "",
            cost: 0,
            author: "",
            name: "",
            email: "",
            phoneNumber: "",
            postingUserId: "",
            postingUserName: "",
            documentId: ""
        )
    }
    

    convenience init(dictionary:[String:Any]) {
        let title = dictionary["title"] as! String? ?? ""
        let cost = dictionary ["cost"] as! Int? ?? 0
        let author = dictionary["author"] as! String
        let name = dictionary["name"] as! String? ?? ""
        let email = dictionary["email"] as! String? ?? ""
       let phoneNumber = dictionary["phoneNumber"] as! String? ?? ""
        let postingUserId = dictionary["postingUserId"] as! String
        let postingUserName = dictionary["postingUserName"] as? String ?? ""

        self.init(title: title,
                  cost: cost,
                  author: author,
                  name: name,
                  email: email,
                 phoneNumber: phoneNumber,
                  postingUserId: postingUserId,
                  postingUserName: postingUserName,
                  documentId: ""
        )
    }
    
    func saveData (completed: @escaping (Bool) -> () ) {
        print("Saving")
        let db = Firestore.firestore()
        
        //Grab User ID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completed (false)
        }
        print("Got user ID")
        self.postingUserId = postingUserID
        
        // Create the dictionary representing the data to save
        let dataToSave = self.dictionary
        
        //if we have saved a record, we'll have a documentID
        if self.documentId != "" {
             print("Has document ID")
            //Post the textbook object under the "Textbooks" collection in Firestore
            let ref = db.collection("Textbooks").document(self.documentId)
            
            //Pushing the textbook into the database
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("***ERROR: updating textbook document \(self.documentId) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^^Textbook document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        } else {
            //This is if the textbook isn't in there already
            print("No document ID")
            var ref: DocumentReference? = nil //Let firestone create new documentID
            print("Adding document")
            ref = db.collection("Textbooks").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("***ERROR: creating new document \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    completed(true)
                }
            }
            print(ref!.documentID)
            print("This shouldn't print")
        }
    }
    
    func deleteData(textbook: Textbook, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        db.collection("Textbooks").document(textbook.documentId).delete() { error in
            if let error = error {
                print("😡 ERROR: deleting review documentID \(textbook.documentId) \(error.localizedDescription)")
                completed(false)
            } else {
                    completed(true)
                }
            }
        }
}



