//
//  GetShoppingItemService.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/27/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation

class GetShoppingItemService:GetService {
    
    override init() {
        super.init()
        
        self.requestURL += "/shoppingitem"
    }
}
