//
//  Image User defaults.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import UIKit

class SaveImage {
   
    static let shared = SaveImage()
    let defaults = UserDefaults.standard
    
    struct ImageDefaults: Codable{
        let imagePro: Data?
    }
    
    var ProfileImageArray: [ImageDefaults]{
        get{
            if let data = defaults.value(forKey: Keys.image.rawValue) as? Data{
                return try! PropertyListDecoder().decode([ImageDefaults].self, from: data)
            }else{
                return [ImageDefaults]()
            }
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: Keys.image.rawValue)
            }
        }
    }
    
    func allSave(image: UIImage){
        let data = NSData(data: image.pngData()!)
        let imageDefaults = ImageDefaults(imagePro: data as Data )
        ProfileImageArray.insert(imageDefaults, at: 0)
    }
}
