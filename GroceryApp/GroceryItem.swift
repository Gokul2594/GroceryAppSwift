//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-06-24.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation

class GroceryItem {
    let id: Int64
    let name: String
    let dateCreated: Date
    var purchased: Bool
    var dateUpdated: Date?
    
    init(name: String) {
        self.id = 0
        self.name = name
        self.dateCreated = Date()
        self.purchased = false
        self.dateUpdated = nil
    }
    
    init(id: Int64, name: String, purchased: Bool, dateCreated: Date, dateUpdated: Date?) {
        self.id = id
        self.name = name
        self.dateCreated = dateCreated
        self.purchased = purchased
        self.dateUpdated = dateUpdated
    }
    
    func purchaseItem() {
        purchased = true
    }
    
    func dateCreatedAsString() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self.dateCreated) + " (created)"
    }
    
    func dateUpdatedAsString() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        return self.dateUpdated != nil ? dateFormatter.string(from: self.dateUpdated!) + " (updated)" : "Yet to update"
    }
}
