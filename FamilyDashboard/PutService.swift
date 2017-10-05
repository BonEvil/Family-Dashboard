//
//  PutService.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/28/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation

class PutService:BaseService {
    
    override init() {
        super.init()
        
        guard let baseUrl = BaseService.baseUrl else {
            return
        }
        
        self.requestURL = baseUrl
        requestType = .PUT
        requestParams = [String:AnyObject]()
    }
}
