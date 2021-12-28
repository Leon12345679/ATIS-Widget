//
//  AirportPickerView.swift
//  Atis
//
//  Created by Leon Vladimirov on 12/28/21.
//

import SwiftUI


struct AirportPickerView: View {
    @State private var airport: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter an Aiport", text: $airport)
                .padding(.leading, 16)
        }
    }
}
