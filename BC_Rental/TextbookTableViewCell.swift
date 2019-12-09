//
//  TextbookTableViewCell.swift
//  BC_Rental
//
//  Created by Ellana Lawrence on 12/9/19.
//  Copyright © 2019 Ellana Lawrence. All rights reserved.
//

import UIKit

class TextbookTableViewCell: UITableViewCell {
    @IBOutlet weak var textbookNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var textbook: Textbook!
    
    func configureCell (textbook: Textbook) {
        textbookNameLabel.text = textbook.title
        costLabel.text = "$" + String(Int(textbook.cost))
        
    }
}

   


