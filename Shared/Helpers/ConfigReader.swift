//
//  ConfigReader.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/26/21.
//

import Foundation


class ConfigReader {
    enum ConfigKey: String {
        case METARAPIKey
    }
    
    static func readProperty<PropertyType>(key: ConfigKey, type: PropertyType.Type) -> PropertyType? {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        else {
            return nil
        }
        
        return config[key.rawValue] as? PropertyType
    }
    
}
