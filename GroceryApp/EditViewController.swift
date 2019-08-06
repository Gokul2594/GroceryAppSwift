//
//  NewViewController.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-07-02.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import UIKit

class EditViewController: UIViewController{
    var item: GroceryItem
    var listManager: GroceryListManager
    
    init(item: GroceryItem){
        self.item = item
        listManager = GroceryListManager()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(purchasedSwitch)
        view.addSubview(purchasedLabel)
        view.addSubview(backButton)
        view.addSubview(saveButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    // Title for the edit view
    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Edit Item"
        view.textAlignment = .center
        view.font = view.font.withSize(20)
        return view
    }()
    
    
    lazy var purchasedLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Purchased"
        view.font = view.font.withSize(20)
        return view
    }()
    
    // Name textfield
    lazy var nameTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font?.withSize(20)
        view.layer.borderWidth = 0.5
        view.text = item.name
        return view
    }()
    
    // Purchased switch
    lazy var purchasedSwitch: UISwitch! = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = item.purchased
        
//        view.addTarget(self, action: #selector(updatePurchasedDate), for: UIControl.Event.valueChanged)
        
        return view
    }()
    
    // Back button
    lazy var backButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Back", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onBackClicked), for: .touchDown)
        
        return view
    }()
    
    lazy var saveButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onSaveClicked), for: .touchDown)
        
        return view
    }()
    
    @objc func onSaveClicked() {
        let editedItem = GroceryItem(id: self.item.id, name: nameTextField.text ?? "Unnamed", purchased: purchasedSwitch.isOn, dateCreated: self.item.dateCreated, dateUpdated: Date())
        listManager.updateItem(item: editedItem)
        
        let detailView: DetailViewController = DetailViewController(item: editedItem)
        
        self.present(detailView, animated: false, completion: nil)
    }
    
    @objc func onBackClicked() {
        self.dismiss(animated: false, completion: nil)
    }
    
    //constraints for the view
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50).isActive = true
        backButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        purchasedSwitch.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        purchasedSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        purchasedLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        purchasedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: purchasedSwitch.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        super.updateViewConstraints()
    }
}
