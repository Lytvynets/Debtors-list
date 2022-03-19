//
//  ViewController.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 17.03.2022.
//

import UIKit
class ProfileViewController: UIViewController {

    @IBOutlet weak var addMinusButton: UIButton!
    @IBOutlet weak var addPlusButton: UIButton!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var youSumLabel: UILabel!
    @IBOutlet weak var allSum: UILabel!
    @IBOutlet weak var allSumYou: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = 55
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.black.cgColor
        self.nameLabel.text = UserDefaults.standard.string(forKey: Keys.nameLabelUserDefaultsIdentifier.rawValue)
        self.profileImage.image = UIImage(data:  SaveImage.shared.ProfileImageArray.first?.imagePro ?? .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.allSumYou.text = "\(youAllSumProfile)"
        self.allSum.text = "\(allSumProfile)"
    }
    
    @IBAction func profileUnwindSegue (_ segue: UIStoryboardSegue){
        guard segue.identifier == Keys.profileUnwindSegueIdentifier.rawValue else { return }
        let segue = segue.source as! SettingsVC
        let name = segue.profileName
        let lastName = segue.profileLastName
        let image = SaveImage.shared.ProfileImageArray[0].imagePro
        self.profileImage.image = UIImage(data: image!)
        self.nameLabel.text = "\(name.profileName ?? "")" + " " + "\(lastName.profileLastName ?? "")"
        UserDefaults.standard.set(nameLabel.text, forKey: Keys.nameLabelUserDefaultsIdentifier.rawValue)
    }

}
