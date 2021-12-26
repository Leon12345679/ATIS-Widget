//
//  METARWeather.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/26/21.
//

import Foundation


struct METARWeather: Codable {
    let results: Int
    let data: [RawData]
    
    struct RawData: Codable {
        let icao: String
        let rawText: String
        
        let station: StationInfo
    }
    
    struct StationInfo: Codable {
        let location: String
        let name: String
        let type: String
    }
}
