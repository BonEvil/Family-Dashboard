//
//  GetService.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/27/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation

class GetService:BaseService {
    
    override init() {
        super.init()
        
        guard let baseUrl = BaseService.baseUrl else {
            return
        }
        
        self.requestURL = baseUrl
        self.requestType = .GET
    }
}
