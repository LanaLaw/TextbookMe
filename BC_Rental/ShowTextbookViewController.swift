//
//  ShowTextbookViewController.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/9/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import UIKit

class ShowTextbookViewController: UIViewController {
    @IBOutlet weak var buyTextbookTitleLabel: UILabel!
    @IBOutlet weak var buyAuthorNameLabel: UILabel!
    @IBOutlet weak var buyCostLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var textbook: Textbook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Textbook Information"

        buyTextbookTitleLabel.text = textbook.title
        buyAuthorNameLabel.text = textbook.author
        buyCostLabel.text = "$" + String(Int(textbook.cost))
        nameLabel.text = textbook.name
        emailLabel.text = textbook.email
        phoneNumberLabel.text = textbook.phoneNumber
        
    }

}
