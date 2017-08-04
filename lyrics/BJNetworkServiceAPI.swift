//
//  BJNetworkServiceAPI.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 4..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import Alamofire

var BJServerPath = "https://lyricsbj.herokuapp.com"

enum BJHttpMethod : String {
    case options    = "OPTIONS"
    case get        = "GET"
    case head       = "HEAD"
    case post       = "POST"
    case put        = "PUT"
    case patch      = "PATCH"
    case delete     = "DELETE"
    case trace      = "TRACE"
    case connect    = "CONNECT"
    case multipart  = "MULTIPART"
}

extension BJHttpMethod : Equatable {
    static func == (lhs:BJHttpMethod, rhs:BJHttpMethod) -> Bool {
        return (lhs.rawValue == rhs.rawValue)
    }
}

protocol BJNetworkServiceAPI {
    var baseURL         : String { get }
    var basePath        : String { get }
    var subPath         : String { get }
    var method          : BJHttpMethod { get }
    var parameters      : [String: Any?]? { get }
    var isRequireLogin  : Bool { get }
    
    var getFullPath     : String { get }
}

enum BJError : Error {
    case error
}

extension BJNetworkServiceAPI {
    var baseURL     : String { return BJServerPath + "/api" }
    var getFullPath : String { return self.baseURL + self.basePath + self.subPath }
    
    private func sendRequest(method:BJHttpMethod, parameters:[String:Any], fullfill:@escaping (Any?) -> Void, reject:@escaping (Error) -> Void) {
        let method = HTTPMethod(rawValue: self.method.rawValue) ?? HTTPMethod.post
        Alamofire.request(self.getFullPath, method: method, parameters: parameters, encoding: URLEncoding.queryString)
            .responseJSON { response in
                self.responseCallback(response:response, fullfill:fullfill, reject:reject)
        }
    }
    
    private func responseCallback(response:DataResponse<Any>, fullfill:@escaping (Any?) -> Void, reject:@escaping (Error) -> Void) {
        
        guard let code = response.response?.statusCode
            else { reject(BJError.error); return}
        
        if code >= 200 && code < 300 {
            fullfill(response.result.value)
        } else {
            reject(BJError.error)
        }
    }
    
    func jsonStringFromDictionary(_ dic:[String:Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            return "{}"
        }
    }
    
    func jsonStringFromArray(_ array:[Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: [])
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }

}
