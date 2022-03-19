//
//  TableViewCell.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    func set(debtorsArray: Debtors){
        self.nameLabel.text = debtorsArray.name
        self.lastNameLabel.text = debtorsArray.lastName
        self.sumLabel.text = ("\(debtorsArray.sum). \(debtorsArray.currency)")
    }
}
