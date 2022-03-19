//
//  SecondTableViewCell.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import UIKit

class YouDebtTableViewCell: TableViewCell {
    
    @IBOutlet weak var youOweNameLabel: UILabel!
    @IBOutlet weak var youOweLastNameLabel: UILabel!
    @IBOutlet weak var youOweSumLabel: UILabel!
    @IBOutlet weak var youOweNumberLabel: UILabel!
     
    func set(youDebtorArray: YourDebtModel){
        self.youOweNameLabel.text = youDebtorArray.name
        self.youOweLastNameLabel.text = youDebtorArray.lastName
        self.youOweSumLabel.text = " - \(youDebtorArray.sum). \(youDebtorArray.currency)"
    }
}
