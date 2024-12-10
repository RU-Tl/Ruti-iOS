//
//  APIService.swift
//  Ruti
//
//  Created by leeyeon2 on 5/22/24.
//
import Foundation
import Alamofire
import UIKit


struct Context{
    var target: String?
    var serviceCategory: String?
    var serviceName: String?
}

struct Message{
    var header: String?
    var payload: Payload?

    struct Payload {
        var pageNumber: Int?
        var rowsPerpage: Int?
    }
}


final class APIService {
    static let shared = APIService()
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    
    func request(context: Context,
                 message: Message ){
//        AF.download().uploadProgress
//        AF.request().pro
    }
    
    
    
    
    // MARK: - perform
    func perform(request: APIRequest,
                 completion: @escaping APIClientCompletion) {
        let url = APIConfig.baseURL + request.path
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url,
                   method: request.method,
                   parameters: request.param,
                   encoding: JSONEncoding.default,
                   headers: request.headers)
        .validate(statusCode: 200..<300)
        .responseString { response in
            switch response.result{
            case .success(_):
                do{
                    let dataString = String(data: response.data!, encoding: .utf8)
                    if let jsonData = dataString!.data(using: .utf8) {
                        if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            completion(.success(APIResponse<Data?>(statusCode: response.response?.statusCode ?? 400,
                                                                   body: jsonDict)))
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            default:
                print(response.result)
            }
        }
    }
}
