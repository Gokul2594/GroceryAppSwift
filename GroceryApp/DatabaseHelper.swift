
//
//  DatabaseHelper.swift
//  GroceryApp
//
//  Created by Gokul Viswanathan on 2019-07-22.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    let db: Connection?
    let groceries = Table("groceries")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let purchased = Expression<Bool>("purchased")
    let dateCreated = Expression<Date>("dateCreated")
    let dateUpdated = Expression<Date?>("dateUpdated")
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/groceries.sqlite3")
            print(path)
            createGroceriesTable()
        } catch (let message) {
            print(message)
            db = nil
        }
    }
    
    private func createGroceriesTable() {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        
        do {
            try db!.run(groceries.create(ifNotExists: true){ t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(purchased, defaultValue: false)
                t.column(dateCreated)
                t.column(dateUpdated)
            })
        } catch (let message) {
            print(message)
        }
    }
    
    func insertItems(grocery: GroceryItem) {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        
        let insert = groceries.insert(
            name <- grocery.name,
            purchased <- grocery.purchased,
            dateCreated <- grocery.dateCreated,
            dateUpdated <- grocery.dateUpdated
        )
        
        do {
            try db!.run(insert)
        } catch (let message) {
            print(message)
        }
    }
    
    func getGroceryItems() -> [GroceryItem]? {
        if(db == nil) {
            print("Unable to get connection")
            return nil
        }
        do {
            var groceryItems: [GroceryItem] = [GroceryItem]()
            
            for row in try db!.prepare(groceries) {
                let grocery = GroceryItem(
                    id: row[id],
                    name: row[name],
                    purchased: row[purchased],
                    dateCreated: row[dateCreated],
                    dateUpdated: row[dateUpdated]
                )
                groceryItems.append(grocery)
            }
            return groceryItems
        } catch (let message) {
            print(message)
            return nil
        }
    }
    
    func updateGroceryItem(grocery: GroceryItem) {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        do {
            let selectedItem = groceries.filter(id == grocery.id)
            try db!.run(selectedItem.update(
                name <- grocery.name,
                purchased <- grocery.purchased,
                dateUpdated <- grocery.dateUpdated
            ))
        } catch (let message) {
            print(message)
        }
    }
    
    func deleteGroceryItem(grocery: GroceryItem) {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        do {
            let selectedItem = groceries.filter(id == grocery.id)
            try db!.run(selectedItem.delete())
        } catch (let message) {
            print(message)
        }
    }
}
