//
//  APIConfig.swift
//  Ruti
//
//  Created by leeyeon2 on 5/22/24.
//

import Foundation
import Alamofire

struct APIConfig {
    static let baseURL = "http://49.50.173.179:8080"
    
    static var headers: HTTPHeaders = ["Accept" : "application/json, application/javascript, text/javascript, text/json",
                                "Content-Type" : "application/json; charset=UTF-8"]
    
    static let authHeaders: HTTPHeaders = ["Accept" : "application/json, application/javascript, text/javascript, text/json",
                                    "Content-Type" : "application/json; charset=UTF-8",
                                           "Authorization" : "Bearer \(UserInfo.token))"]

    static let multiPartHeaders: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
}
