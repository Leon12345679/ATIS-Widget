//
//  METARService.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/28/21.
//

import Foundation
import Combine


class METARService {
    private let networkingLayer = NetworkingLayer()

    func fetchMETAR(for icao: String) -> AnyPublisher<METARWeather, NetworkError> {
        guard let apiKey = ConfigReader.readProperty(key: .METARAPIKey, type: String.self) else {
            return AnyPublisher(
                Fail(error: NetworkError.invalidRequest)
            )
        }
                
        let metarRequest = NetworkRequest(
            endpoint: Endpoint.metar(icao: icao).endpoint,
            headers: ["X-API-Key": apiKey],
            httpMethod: .GET
        )
        
        return networkingLayer.runRequest(metarRequest)
    }
}

extension METARService {
    static let baseURL: String = "https://api.checkwx.com/"
    
    enum Endpoint {
        case metar(icao: String)
        
        var endpoint: String {
            switch self {
            case .metar(let icao):
                return METARService.baseURL + "metar/\(icao)/decoded"
            }
        }
    }
    
}
