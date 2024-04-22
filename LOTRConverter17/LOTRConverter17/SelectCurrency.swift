//
//  SelectCurrency.swift
//  LOTRConverter17
//
//  Created by Sunggon Park on 2024/04/01.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Select the currency your are starting with:")
                    .fontWeight(.bold)
                
                IconGrid(currency: $topCurrency)
                
                Text("Select the currency tou would like to convert to:")
                    .fontWeight(.bold)
                
                
                IconGrid(currency: $bottomCurrency)
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
            }
            
            .multilineTextAlignment(.center)
            .padding()
        }
    }
}

#Preview {
    SelectCurrency(
        topCurrency: .constant(.copperPenny),
        bottomCurrency: .constant(.silverPenny)
    )
}

