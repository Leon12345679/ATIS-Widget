//
//  ConfigReader.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/26/21.
//

import Foundation


class ConfigReader {
    enum ConfigKey: String {
        case WeatherAPIKey
    }
    
    static func readProperty<PropertyType>(key: ConfigKey, type: PropertyType) -> PropertyType? {
        return nil
    }
    
}
