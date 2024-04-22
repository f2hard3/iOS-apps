//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Sunggon Park on 2024/04/04.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    @State private var showCharacterInfo = false
    
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.8, height: geo.size.height * 1.2)
                VStack {
                    VStack {
                        Spacer(minLength: 144)
                        
                        switch viewModel.status {
                        case .success(data: (let quote, let character)):
                            Text("\"\(quote.quote)\"")
                                .minimumScaleFactor(0.6)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 24))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.2, height: geo.size.height / 2.0)
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                                .sheet(isPresented: $showCharacterInfo) {
                                    CharacterView(show: show, character: character)
                                }
                                
                                Text(character.name)
                                    .padding(12)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            } // ZStack
                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 2.0)
                            .clipShape(.rect(cornerRadius: 80))
                            
                        case .fetching:
                            ProgressView()
                            
                        default:
                            EmptyView()
                            
                        } // switch viewModel.status
                        
                        Spacer()
                    } // VStack
                    
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .padding()
                            .background(show.buttonColor)
                            .clipShape(.rect(cornerRadius: 8))
                            .shadow(color: show.shadowColor, radius: 4)
                    }
                    
                    Spacer(minLength: 172)
                } // VStack
                .frame(width: geo.size.width)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding()
            } // Zstack
            .frame(width: geo.size.width, height: geo.size.height)
        } // GeometryReader
        .ignoresSafeArea()
    }
}

#Preview {
//    QuoteView(show: K.bbName)
    QuoteView(show: K.bbName)
//        .preferredColorScheme(.dark)
}
