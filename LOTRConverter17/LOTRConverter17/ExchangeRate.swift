//
//  ExchangeRate.swift
//  LOTRConverter17
//
//  Created by Sunggon Park on 2024/04/01.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let text: String
    let RightImage: ImageResource
    
    var body: some View {
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            Text(text)
            
            Image(RightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(
        leftImage: .goldpiece,
        text: "1 Gold Piece = 4 Gold Pennies",
        RightImage: .goldpenny
    )
}
