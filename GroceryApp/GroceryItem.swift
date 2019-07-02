//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-06-24.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation

class GroceryItem {
    let name: String
    let dateCreated: Date
    var purchased: Bool
    
    init(name: String, purchased: Bool = false) {
        self.name = name
        self.dateCreated = Date()
        self.purchased = false
    }
    
    func purchaseItem() {
        purchased = true
    }
    
    func dateCreatedAsString() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self.dateCreated)
    }
}
