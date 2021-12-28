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

    func fetchMETAR(icao: String) -> AnyPublisher<METARWeather, NetworkError> {
        let metarRequest = NetworkRequest(
            endpoint: Endpoint.metar.endpoint,
            httpMethod: .GET
        )
        
        return networkingLayer.runRequest(metarRequest)
    }
}

extension METARService {
    
    enum Endpoint: String {
        case metar = ""
        
        var endpoint: String {
            #if DEVELOP
            let baseURL = ""
            #elseif PROD
            let baseURL = ""
            #endif
            
            return baseURL + self.rawValue
        }
    }
    
}
