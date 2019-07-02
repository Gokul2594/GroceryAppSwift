//
//  DetailViewController.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-07-02.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var item: GroceryItem
    
    init(item: GroceryItem){
        self.item = item
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = item.name
        dateCreatedLabel.text = item.dateCreatedAsString()
        purchasedSwitch.isOn = item.purchased
        datePurchasedLabel.text = "Yet to complete"
        
        view.addSubview(descriptionLabel)
        view.addSubview(dateCreatedLabel)
        view.addSubview(purchasedSwitch)
        view.addSubview(backButton)
        view.addSubview(datePurchasedLabel)
        view.addSubview(editButton)
        view.setNeedsUpdateConstraints()
    }
    
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var purchasedSwitch: UISwitch! = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = false
        
        view.addTarget(self, action: #selector(updatePurchasedDate), for: UIControl.Event.valueChanged)
        
        return view
    }()
    
    @objc func updatePurchasedDate(mySwitch: UISwitch){
        if(mySwitch.isOn){
            let dateFormatter = DateFormatter()
            let dateFormat = "MMM dd, YYYY - h:mm a"
            dateFormatter.dateFormat = dateFormat
            datePurchasedLabel.text = dateFormatter.string(from: Date())
        }
        else{
            datePurchasedLabel.text = "Yet to purchase"
        }
    }
    
    lazy var backButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Back", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onBackClicked), for: .touchDown)
        
        return view
    }()
    
    lazy var datePurchasedLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var editButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Edit", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onEditClicked), for: .touchDown)
        
        return view
    }()
    
    @objc func onBackClicked() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func onEditClicked() {
        let editView: EditViewController = EditViewController(item: item)
        self.present(editView, animated: false, completion: nil)
    }
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50).isActive = true
        backButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true

        
        descriptionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        dateCreatedLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        datePurchasedLabel.topAnchor.constraint(equalTo: dateCreatedLabel.bottomAnchor, constant: 10).isActive = true
        
        datePurchasedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        purchasedSwitch.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        purchasedSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        editButton.topAnchor.constraint(equalTo: datePurchasedLabel.bottomAnchor, constant: 30).isActive = true
        editButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        editButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        
        super.updateViewConstraints()
    }
}
