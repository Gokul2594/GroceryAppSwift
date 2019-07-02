//
//  GroceryItemCell.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-06-24.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import UIKit

class GroceryItemCell: UITableViewCell {
    var groceryItem: GroceryItem? {
        didSet {
            if let item = groceryItem {
                nameLabel.text = item.name
                dateCreatedLabel.text = item.dateCreatedAsString()
                
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateCreatedLabel)
        contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard")
    }
    
    lazy var nameLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.textColor = UIColor.black
        view.font = view.font.withSize(12)
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.textColor = UIColor.black
        view.font = view.font.withSize(12)
        return view
    }()
    
    override func updateConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        nameLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        dateCreatedLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 100).isActive = true
        super.updateConstraints()
    }
}
