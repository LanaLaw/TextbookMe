//
//  TextbookDetailViewController.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/4/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import UIKit


class TextbookDetailViewController: UIViewController {
    
    @IBOutlet weak var textbookTitleTextField: UITextField!
    @IBOutlet weak var authorNameTextField: UITextField!
    
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var sellerNameTextField: UITextField!
    @IBOutlet weak var sellerEmailTextField: UITextField!
    @IBOutlet weak var sellerPhoneNumberTextField: UITextField!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
   //var textbook: String!
    var textbook: Textbook!
    var textbooks: Textbooks!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if textbook == nil {
            textbook = Textbook()
        }
        self.navigationItem.title = "Textbook Info"

        
//        if let textbook = textbook{
//            textbookNameField.text = textbook
//            self.navigationItem.title = "Edit Textbook Info"
//        }
//        if let textbook = textbook {
//            toDoNoteView.text = toDoNoteItem
//        } else{
//            self.navigationItem.title = "New To Do Item"
//        }
        
        textbookTitleTextField.text = textbook.title
        authorNameTextField.text = textbook.author
        costTextField.text = String(Double(textbook.cost))
        sellerNameTextField.text = textbook.name
        sellerEmailTextField.text = textbook.email
        sellerPhoneNumberTextField.text = textbook.phoneNumber
        enableDisableButton()
        textbookTitleTextField.becomeFirstResponder()

        }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//         
//        textbooks.loadData(textbook: textbook) {
//             self.tableView.reloadData()
//         }
//         
//         
//     }
//    
    
    
    func leaveViewController() {
        print("Leaving VC")
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            print("Is presenting in add mode")
            dismiss(animated: true, completion: nil)
        } else {
            print("Is not presenting in add mode")
            navigationController?.popViewController(animated: true)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        textbook.title = textbookTitleTextField.text!
        textbook.author = authorNameTextField.text!
    }
    
    
    
    func enableDisableButton(){
          if let textbookNameFieldCount = textbookTitleTextField.text?.count, textbookNameFieldCount > 0 {
              saveBarButton.isEnabled = true
          } else {
              saveBarButton.isEnabled = false
          }
      }
    
    @IBAction func textbookNameFieldChanged(_ sender: UITextField) {
       enableDisableButton()
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        saveTextbook()
    }
    
    
    func saveTextbook () {
        let title = textbookTitleTextField.text ?? ""
        let costString = costTextField.text ?? "0.0"
        let cost = Double(costString) ?? 0.0
        let name = sellerNameTextField.text ?? ""
        let email = sellerEmailTextField.text ?? ""
        let phoneNumber = sellerPhoneNumberTextField.text ?? ""
        let author = authorNameTextField.text ?? ""
        
        //This stays the same
        let newTextbook = Textbook()
           
        newTextbook.title = title
        newTextbook.cost = cost
        newTextbook.name = name
        newTextbook.email = email
        newTextbook.phoneNumber = phoneNumber
        newTextbook.author = author
           
        newTextbook.saveData(){ (success) in
            print("Textbook supposedly successfully saved I think")
            print(success)
            if success {
                self.leaveViewController()
            } else {
                print("***ERROR: Couldn't leave this view controller because data wasn't saved.")
            }
        }
    }
    
    
    
    //Rememeber that this is a test function
    //Write a new function called saveTextbook()
    //Inside save button pressed, call the func
    func saveTestTextbook() {
        //In your IB action for when the seller saves their post:
        //Instead of hard coding these variables, get them from the IBOutlets
        //i.e. let title = titleTextField.text
        //i.e. let cost = costTextField.text as?? Double
        let title = "Swift Book 1.0"
        let cost = 20.0
        let author = "Linda"
        
        //This stays the same
        let newTextbook = Textbook()
        
        newTextbook.title = title
        newTextbook.cost = cost
        newTextbook.author = author
        
        newTextbook.saveData(){ (success) in
            print("Textbook supposedly successfully saved I think")
        }
    }
    
    
}

//extension TextbookDetailViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return textbooks.textbookArray.count
//      //  return reviews.reviewArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCurrentOffersViewController
//        cell.textbook = textbooks.textbookArray[indexPath.row]
//        return cell
//    }
//}
