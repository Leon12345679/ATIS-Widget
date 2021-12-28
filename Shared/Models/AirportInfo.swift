//
//  AirportInfo.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/28/21.
//

import Foundation


struct AirportInfo: Codable {
    let results: Int
    let data: [RawData]
    
    struct RawData: Codable {
        let icao: String
        let name: String
    }
}
