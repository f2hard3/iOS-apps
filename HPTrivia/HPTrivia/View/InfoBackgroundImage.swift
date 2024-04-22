//
//  InstructionBackground.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/09.
//

import SwiftUI

struct InfoBackgroundImage: View {
    var body: some View {
        Image(.parchment)
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

#Preview {
    InfoBackgroundImage()
}
