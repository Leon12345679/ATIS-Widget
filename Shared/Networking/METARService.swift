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
        let metarRequest = NetworkRequest(
            endpoint: Endpoint.metar(icao: icao).endpoint,
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
