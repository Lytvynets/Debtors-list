//
//  MainViewControllerExtensions.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 24.04.2024.
//

import Foundation
import UIKit

extension MainViewController: CommonViewDelegate {
    func presentActionSheet(alertController: UIAlertController) {
        present(alertController, animated: true)
    }
    
    
    func showNewDebtorScreen() {
        let vc = AddNewDebtViewController(state: false)
        vc.editDataDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MainViewController: ShowEditDataDelegate {
    func showEditScreen(vc: UIViewController) {
        present(vc, animated: true)
    }
}


extension MainViewController: EditDataDelegate {
    func reloadTableView() {
        viewModel.removeAllData()
        viewModel.addToLastOperationsArray()
        commonView.mainTableView.sortedArray = viewModel.array
        viewModel.sumLabelsInfo { yourDebt, debtor in
            self.commonView.infoView.youDebtLabel.text = yourDebt
            self.commonView.infoView.debtLabel.text = debtor
        }
        commonView.mainTableView.reloadData()
    }
}
