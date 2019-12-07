//
//  MyCurrentOffersViewController.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/3/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class MyCurrentOffersViewController: UIViewController {

    @IBOutlet weak var booksToOfferTableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    

  //  var textbooks = ["Let Nobody Turn Us Around", "The Fire Next Time"]
    //var textbook: Textbook!
    var textbooks: Textbooks!
    var authUI: FUIAuth!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        authUI = FUIAuth.defaultAuthUI()
//        authUI?.delegate = self
//
        booksToOfferTableView.delegate = self
        booksToOfferTableView.dataSource = self
       // booksToOfferTableView.isHidden = true
        // Do any additional setup after loading the view.
        textbooks = Textbooks()
        self.navigationItem.title = "My Current Offers"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        textbooks.loadData {
            print("Textbooks downloaded")
            self.booksToOfferTableView.reloadData()
          
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ShowTextbook" {
               let destination = segue.destination as! TextbookDetailViewController
               let selectedIndexPath = booksToOfferTableView.indexPathForSelectedRow!
            //   destination.textbook = textbooks[selectedIndexPath.row]
            destination.textbook = textbooks.textbookArray[selectedIndexPath.row]
           } else {
               if let selectedPath = booksToOfferTableView.indexPathForSelectedRow {
                   booksToOfferTableView.deselectRow(at: selectedPath, animated: true)
               }
           }
       }
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//              if (segue.identifier == "ShowTextbook") {
//                  let destination = segue.destination as! TextbookDetailViewController
//                  let selectedIndexPath = booksToOfferTableView.indexPathForSelectedRow!
//                  destination.textbook = TextbookManager.textbookArray[selectedIndexPath.row]
//              }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "ShowSpot") {
//            let destination = segue.destination as! SpotDetailViewController
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.spot = spots.spotArray[selectedIndexPath.row]
//        }
//    }
//
    
    
    @IBAction func editBarButtonPressed(_ sender: Any) {
        if booksToOfferTableView.isEditing{
                 booksToOfferTableView.setEditing(false, animated: true)
                 editBarButton.title = "Edit"
                 addBarButton.isEnabled = true
             } else {
                 booksToOfferTableView.setEditing(true, animated: true)
                 editBarButton.title = "Done"
                 addBarButton.isEnabled = false
             }
    }
    
    
    @IBAction func addBarButtonPressed(_ sender: Any) {
    }
    

}

extension MyCurrentOffersViewController: UITableViewDelegate, UITableViewDataSource  {
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("working")
    return textbooks.textbookArray.count
   // return species.speciesArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = textbooks.textbookArray[indexPath.row].title
  //  cell.textLabel?.text = species.speciesArray[indexPath.row].name
    return cell
}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            textbooks.textbookArray.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
         }
     
     }
     
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = textbooks.textbookArray[sourceIndexPath.row]
        textbooks.textbookArray.remove (at:sourceIndexPath.row)
        textbooks.textbookArray.insert(itemToMove, at: destinationIndexPath.row)
}
}

