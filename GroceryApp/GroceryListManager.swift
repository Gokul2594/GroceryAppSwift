//
//  GroceryListManager.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-07-22.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation
class GroceryListManager {
    
    let databaseHelper: DatabaseHelper
    
    init() {
        databaseHelper = DatabaseHelper()
    }
    
    func getItems() -> [GroceryItem] {
        return self.databaseHelper.getGroceryItems() ?? [GroceryItem]()
    }
    
    func count() -> Int {
        return self.getItems().count
    }
    
    func addItem(item: GroceryItem) {
        self.databaseHelper.insertItems(grocery: item)
    }
    
    func updateItem(item: GroceryItem) {
        self.databaseHelper.updateGroceryItem(grocery: item)
    }
    
    func deleteItem(item: GroceryItem) {
        self.databaseHelper.deleteGroceryItem(grocery: item)
    }
    
}
