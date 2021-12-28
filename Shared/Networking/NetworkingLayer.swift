//
//  NetworkingLayer.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/26/21.
//

import Foundation
import Combine


class NetworkingLayer {
    
    func runRequest<ResponseType: Codable>( _ request: NetworkRequest) -> AnyPublisher<ResponseType, NetworkError> {
        guard let urlRequest = request.buildURLRequest(with: Constants.baseURL) else {
            return AnyPublisher(
                Fail(error: NetworkError.invalidRequest)
            )
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { serverResponse in
                guard serverResponse.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, message: "Server error")
                }
                
                return serverResponse.data
            }
            .decode(
                type: ResponseType.self,
                decoder: JSONDecoder()
            )
            .mapError { decodingError in
                NetworkError.decoderError(error: decodingError)
            }
            .eraseToAnyPublisher()
    }
    
    enum NetworkError: Error {
        case badURL(_ message: String)
        case apiError(code: Int, message: String)
        case decoderError(error: Error)
        case unauthorized(code: Int, message: String)
        case badRequest(code: Int, message: String)
        case serverError(code: Int, message: String)
        case noResponse(_ message: String)
        case unableToParseData(_ message: String)
        case unknown(code: Int, message: String)
        case invalidRequest
    }
}
