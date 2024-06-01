//
//  CommonView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.03.2024.
//

import Foundation
import UIKit

protocol CommonViewDelegate {
    func showNewDebtorScreen()
    func presentActionSheet(alertController: UIAlertController)
}


class CommonView: UIView {
 
    lazy var infoView = InfoView()
    lazy var mainTableView = MainTableView()
    lazy var blurView = BlurView()
    var commonViewDelegate: CommonViewDelegate?
    
    
    private lazy var addButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addNewDebtorButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var filterButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(infoView)
        addSubview(addButton)
        addSubview(filterButton)
        addSubview(mainTableView)
        addSubview(blurView)
        setConstraints()
        colorSettings()
        setupBlurView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            infoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/7.5),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 5),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            filterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            filterButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 3),
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            filterButton.widthAnchor.constraint(equalToConstant: 50),
            mainTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 3),
            mainTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    func setupBlurView() {
        blurView.alpha = 0
        blurView.applyBlurEffect()
        NSLayoutConstraint.activate([
            blurView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: centerYAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor, constant: frame.width),
            blurView.heightAnchor.constraint(equalTo: heightAnchor, constant: frame.height),
        ])
    }
    
    
    func colorSettings() {
        backgroundColor = SetColors.currentColor.backgroundColor
        infoView.backgroundColor = SetColors.currentColor.infoViewColor
        mainTableView.backgroundColor = SetColors.currentColor.backgroundColor
        addButton.tintColor = SetColors.currentColor.labelsColor
        filterButton.tintColor = SetColors.currentColor.labelsColor
    }
    
    
    
    //MARK: - Actions
    @objc private func addNewDebtorButtonAction() {
        commonViewDelegate?.showNewDebtorScreen()
    }
    
    
    @objc private func filterButtonAction() {
        
        let alertController = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        
        let showOnlyGiven = UIAlertAction(title: "Show only given", style: .default) { (_) in
            self.mainTableView.filterTableView = .showGiven
            self.mainTableView.addData()
        }
        
        let showOnlyTaken = UIAlertAction(title: "Show only taken", style: .default) { (_) in
            self.mainTableView.filterTableView = .showTaken
            self.mainTableView.addData()
        }
        
        let showAll = UIAlertAction(title: "Show all", style: .default) { (_) in
            self.mainTableView.filterTableView = .showAll
            self.mainTableView.addData()
        }
        
        let cancelAction = UIAlertAction(title: "Скасувати", style: .cancel, handler: nil)
        alertController.addAction(showOnlyGiven)
        alertController.addAction(showOnlyTaken)
        alertController.addAction(showAll)
        alertController.addAction(cancelAction)
        commonViewDelegate?.presentActionSheet(alertController: alertController)
    }
}
