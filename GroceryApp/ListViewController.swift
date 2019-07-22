//
//  ViewController.swift
//  GroceryList
//
//  Created by Gokul Viswanathan on 2019-06-08.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.

import UIKit

class ListViewController: UIViewController {
    var listManager: GroceryListManager
    
    init() {
        listManager = GroceryListManager()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cannot be created from storyboard")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(newButton)
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Grocery List"
        view.textAlignment = .center
        view.font = view.font.withSize(20)
        return view
    }()
    
    lazy var tableView: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        view.tableFooterView = UIView(frame: .zero)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        view.dataSource = self
        view.delegate = self
        view.register(GroceryItemCell.self, forCellReuseIdentifier: NSStringFromClass(GroceryItemCell.self))
        return view
    }()
    
    lazy var newButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("New", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onNewClicked), for: .touchDown)
        
        return view
    }()
    
    @objc func onNewClicked() {
        let dialog = UIAlertController(
            title: "Add Item",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
        
        dialog.addTextField { (textField) in
            textField.placeholder = "What do you want to buy?"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        dialog.addAction(cancelButton)
        let saveButton = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {(action) in
            if let itemField = dialog.textFields?[0] {
                
                if let item = itemField.text {
                    let groceryItem = GroceryItem(name: item)
                    self.listManager.addItem(item: groceryItem)
                    self.tableView.reloadData()
                }
            }
        })
        dialog.addAction(saveButton)
        present(dialog, animated: true, completion: nil)
    }
    
    func reloadView() {
        self.tableView.reloadData()
    }
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        newButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        newButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5).isActive = true
        super.updateViewConstraints()
    }
}
extension ListViewController : UITableViewDelegate {
    
}

extension ListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.listManager.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(GroceryItemCell.self),
            for: indexPath
            ) as! GroceryItemCell
        
        cell.groceryItem = self.listManager.getItems()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = self.listManager.getItems()[indexPath.row]
        let detailView: DetailViewController = DetailViewController(item: item)
        self.present(detailView, animated: false, completion: nil)
    }
}

