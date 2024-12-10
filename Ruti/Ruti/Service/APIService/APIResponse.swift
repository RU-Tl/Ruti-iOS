//
//  APIResponse.swift
//  Ruti
//
//  Created by leeyeon2 on 5/22/24.
//

import Foundation

//MARK: APIResult
enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

//MARK: APIResponse
struct APIResponse<Body> {
    let statusCode: Int
    let body: [String: Any]
}
