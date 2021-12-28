//
//  NetworkRequest.swift
//  Atis (iOS)
//
//  Created by Leon Vladimirov on 12/28/21.
//

import Foundation


struct NetworkRequest {
    let endpoint: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    init(
        endpoint: String,
        headers: [String: String]? = nil,
        body: Encodable? = nil,
        reqTimeout: Float? = nil,
        httpMethod: HTTPMethod
    ) {
        self.endpoint = endpoint
        self.headers = headers
        self.body = body?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    init(
        endpoint: String,
        headers: [String: String]? = nil,
        body: Data? = nil,
        reqTimeout: Float? = nil,
        httpMethod: HTTPMethod
    ) {
        self.endpoint = endpoint
        self.headers = headers
        self.body = body
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(for environment: NetworkingEnvironment) -> URLRequest? {
        guard let url = URL(string: environment.baseURL + endpoint) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
