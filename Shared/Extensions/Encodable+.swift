//
//  Encodable+.swift
//  Atis (iOS)
//
//  Created by Leon Vladimirov on 12/28/21.
//

import Foundation


extension Encodable {
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
