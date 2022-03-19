//
//  SettingsViewController.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import UIKit
import RealmSwift

class SettingsVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    var profileName = ProfileInfoModel(lastName: "")
    var profileLastName = ProfileInfoModel(lastName: "")
 
    //MARK: - Outlets
    @IBOutlet weak var nameUserButton: UIButton!
    @IBOutlet weak var lastNameUserButton: UIButton!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var surnameUserLabel: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.picker.delegate = self
        self.picker.allowsEditing = true
    }
    
    
    //MARK: - Buttons for user authorization
    @IBAction func addImageButton(_ sender: UIButton) {
        self.picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    //Adding a profile photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageProfile.image = originImage
        SaveImage.shared.allSave(image: originImage)
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Adding a username
    @IBAction func nameUserButtonAction(_ sender: UIButton) {
        let alert=UIAlertController(title: "Ведите имя", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            let user = alert.textFields!
            self.profileName = ProfileInfoModel(name: user[0].text ?? "")
            self.nameUserLabel.text = user[0].text
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Adding a user's last name
    @IBAction func surnameUserButtonAction(_ sender: UIButton) {
        let alert=UIAlertController(title: "Ведите Фамилию", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            let user = alert.textFields!
            self.profileLastName = ProfileInfoModel(lastName: user[0].text ?? "")
            self.surnameUserLabel.text = user[0].text
        }))
        present(alert, animated: true, completion: nil)
    }
}
