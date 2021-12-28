//
//  METARService.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/28/21.
//

import Foundation
import Combine


class METARNetworkService {
    private let networkingLayer = NetworkingLayer()
    private let serviceHeaders: [String: String]
    
    init() {
        let apiKey = ConfigReader.readProperty(key: .METARAPIKey, type: String.self)
        
        guard let metarAPIKey = apiKey else {
            fatalError("Failed to read METAR API Key from Config.plist")
        }
        
        serviceHeaders = [
            "X-API-Key": metarAPIKey
        ]
    }
    
    func fetchMETAR(for icao: String) -> AnyPublisher<METARWeather, NetworkError> {
        let metarRequest = NetworkRequest(
            endpoint: Endpoint.metar(icao: icao).endpoint,
            headers: serviceHeaders,
            httpMethod: .GET
        )
        
        return networkingLayer.runRequest(metarRequest)
    }
}

extension METARNetworkService {
    static let baseURL: String = "https://api.checkwx.com/"
    
    enum Endpoint {
        case metar(icao: String)
        
        var endpoint: String {
            switch self {
            case .metar(let icao):
                return METARNetworkService.baseURL + "metar/\(icao)/decoded"
            }
        }
    }
    
}
