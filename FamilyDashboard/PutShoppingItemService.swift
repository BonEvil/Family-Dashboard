//
//  PutShoppingItemService.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/28/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation

class PutShoppingItemService: PutService {
    
    init(id:String, puchased:Bool) {
        super.init()
        
        self.requestURL += "/shoppingitem"
        
        requestParams?["id"] = id as AnyObject
        requestParams?["purchased"] = (puchased) ? "1" as AnyObject : "0" as AnyObject;
    }
}
