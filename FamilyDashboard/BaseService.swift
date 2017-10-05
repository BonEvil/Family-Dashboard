//
//  BaseService.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/28/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation
import DPSessionManager

class BaseService:DPService {
    static var baseUrl:String?
    
    var requestType:DPRequestType = .POST
    var contentType:DPContentType = .FORM
    var acceptType:DPAcceptType = .JSON
    var timeout:TimeInterval = 30
    var requestURL:String = ""
    
    var requestParams:[String:AnyObject]?
    var additionalHeaders:[String:String]?
    
    var customContentType:String?
    var customAcceptType:String?
    var requestSerializer:DPRequestSerializer?
    var responseParser:DPResponseParser?
    var credential:URLCredential?
}
