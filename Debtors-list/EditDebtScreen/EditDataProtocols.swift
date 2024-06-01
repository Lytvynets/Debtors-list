//
//  EditDataProtocols.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation
import UIKit

protocol EditDataDelegate {
    func reloadTableView()
}


protocol ShowEditDataDelegate {
    func showEditScreen(vc: UIViewController)
}
