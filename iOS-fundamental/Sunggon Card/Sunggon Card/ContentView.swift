//
//  ContentView.swift
//  Sunggon Card
//
//  Created by Sunggon Park on 2024/02/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52, opacity: 1.0)
                .ignoresSafeArea()
            VStack {
                Image("sunggon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                Text("Sunggon Park")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundStyle(.white)
                Text("iOS Developer")
                    .font(.system(size: 25))
                    .foregroundStyle(.white)
                Divider()
                InfoView(text: "+81 80 3306 0958", imageName: "phone.fill")
                InfoView(text: "f2hard3@gmail.com", imageName: "envelope.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
