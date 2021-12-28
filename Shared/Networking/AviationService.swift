//
//  METARService.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/28/21.
//

import Foundation
import Combine


class AviationNetworkService {
    private static let baseURL: String = "https://api.checkwx.com/"
    
    private let networkingLayer = NetworkingLayer()
    private let serviceHeaders: [String: String]
    
    init() {
        let apiKey = ConfigReader.readProperty(key: .AviationServiceAPIKey, type: String.self)
        
        guard let aviationAPIKey = apiKey else {
            fatalError("Failed to read Service API Key from Config.plist")
        }
        
        serviceHeaders = [
            "X-API-Key": aviationAPIKey
        ]
    }
    
    func fetchMETAR(for icao: String) -> AnyPublisher<METARWeather, NetworkError> {
        let metarRequest = NetworkRequest(
            endpoint: EndpointType.metar(icao: icao).endpoint,
            headers: serviceHeaders,
            httpMethod: .GET
        )
        
        return networkingLayer.runRequest(metarRequest)
    }
    
    func fetchNearestICAO(lat: Double, long: Double) -> AnyPublisher<ICAOInfo, NetworkError> {
        let icaoRequest = NetworkRequest(
            endpoint: EndpointType.nearestICAO(lat: lat, long: long).endpoint,
            headers: serviceHeaders,
            httpMethod: .GET
        )
        
        return networkingLayer.runRequest(icaoRequest)
    }
}


// MARK: - Endpoint Type

extension AviationNetworkService {
    
    enum EndpointType {
        case metar(icao: String)
        case nearestICAO(lat: Double, long: Double)
        
        var endpoint: String {
            var endpointPath: String
            
            switch self {
            case .metar(let icao):
                endpointPath = "metar/\(icao)/decoded"
                
            case .nearestICAO(let latitude, let longitude):
                endpointPath = "station/lat/\(latitude)/lon/\(longitude)/radius/100"
            }
            
            return AviationNetworkService.baseURL + endpointPath
        }
    }
    
}
