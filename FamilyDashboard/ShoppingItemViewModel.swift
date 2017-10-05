//
//  ShoppingListViewModel.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/27/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation
import DPSessionManager

struct ShoppingItem {
    var id:String!
    var name:String!
    var purchased:Bool!
}

class ShoppingItemViewModel {
    
    typealias ShoppingItemCallback = ([ShoppingItem]) -> ()
    
    var shoppingItemCallback:ShoppingItemCallback!
    
    init(callback:@escaping ShoppingItemCallback) {
        shoppingItemCallback = callback
        retrieveShoppingItems()
    }
    
    func retrieveShoppingItems() {
        let service = GetShoppingItemService()
        DPSessionManager.sharedInstance().start(service) { [unowned self](error, response) in
            var shoppingItems = [ShoppingItem]()
            if let err = error {
                print("error retrieving items: "+err.localizedDescription)
                if let res = err.userInfo["Response"] as? Data {
                    if let string = String(bytes: res, encoding: String.Encoding.utf8) {
                        print(string)
                    }
                }
            } else {
                if let response = response as? [String:Any] {
                    if let items = response["items"] as? [[String:Any]] {
                        for item in items {
                            if let id = item["_id"] as? String, let purchased = item["purchased"], let name = item["name"] as? String {
                                let value = ("\(purchased)" == "0") ? false : true;
                                let newItem = ShoppingItem(id: id, name: name, purchased: value)
                                shoppingItems.append(newItem)
                            }
                        }
                    }
                }
            }
            self.sortItems(items: shoppingItems)
        }
    }
    
    func sortItems(items:[ShoppingItem]) {
        var itemsNotPurchased = [ShoppingItem]()
        var itemsPurchased = [ShoppingItem]()
        
        for item in items {
            if item.purchased {
                itemsPurchased.append(item)
            } else {
                itemsNotPurchased.append(item)
            }
        }
        
        let sortedNotPurchased = itemsNotPurchased.sorted(by: { (first, second) -> Bool in
            return first.name < second.name
        })
        let sortedPurchased = itemsPurchased.sorted(by: { (first, second) -> Bool in
            return first.name < second.name
        })
        let combined = sortedNotPurchased + sortedPurchased
        self.shoppingItemCallback(combined)
    }
}
