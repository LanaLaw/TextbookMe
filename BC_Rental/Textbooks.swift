//
//  Textbooks.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/6/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
 
class Textbooks {
     var textbookArray = [Textbook]()
     var db: Firestore!
    
    //This is JUST for loading
    init() {
        db = Firestore.firestore()
    }
        func loadData(completed: @escaping () -> ()) {
        db.collection("Textbooks").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("***ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.textbookArray = []
            //There are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents {
                let textbook = Textbook(dictionary: document.data())
                textbook.documentId = document.documentID
                self.textbookArray.append(textbook)
            }
            completed()
        }
    }
}



// OLD CODE:
//
//class Textbooks {
//     var textbookArray = [Textbook]()
//    static var db: Firestore!
//
//    //This is JUST for loading
//    static func loadData(completed: @escaping () -> ()) {
//        db = Firestore.firestore()
//        db.collection("Textbooks").addSnapshotListener { (querySnapshot, error) in
//            guard error == nil else {
//                print("***ERROR: adding the snapshot listener \(error!.localizedDescription)")
//                return completed()
//            }
//            Textbooks.textbookArray = []
//            //There are querySnapshot!.documents.count documents in the spots snapshot
//            for document in querySnapshot!.documents {
//                let textbook = Textbook(dictionary: document.data())
//                textbook.documentId = document.documentID
//                Textbooks.textbookArray.append(textbook)
//            }
//            completed()
//        }
//    }
//}
