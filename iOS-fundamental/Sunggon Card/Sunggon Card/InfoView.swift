//
//  InfoView.swift
//  Sunggon Card
//
//  Created by Sunggon Park on 2024/02/28.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String

    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 50)
            .foregroundStyle(.white)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundStyle(.green)
                    Text(text)
                        .foregroundStyle(Color("InfoColor"))
                }
            )
            .padding(.all)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InfoView(text: "+81 80 3306 0958", imageName: "phone.fill")
}
