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
    
    init(item: GroceryItem){
        self.item = item
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        
        view.setNeedsUpdateConstraints()
    }
    
    //title for the edit view
    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Edit Item"
        view.textAlignment = .center
        view.font = view.font.withSize(20)
        return view
    }()
}
