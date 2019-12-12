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
            for document in querySnapshot!.documents {
                let textbook = Textbook(dictionary: document.data())
                textbook.documentId = document.documentID
                self.textbookArray.append(textbook)
            }
            completed()
        }
    }
}


