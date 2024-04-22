//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Sunggon Park on 2024/04/04.
//

import SwiftUI

struct CharacterView: View {
    let show: String
    let character: Character
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    VStack {
                        AsyncImage(url: character.images.randomElement()) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    } // VStack
                    .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.6)
                    .clipShape(.rect(cornerRadius: 24))
                    .padding(.top, 64)
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        
                        Divider()
                        
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        
                        Text("Born: \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occupations:")
                        
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        Text("NickNames:")
                        
                        if character.aliases.isEmpty {
                            Text("None")
                        } else {
                            ForEach(character.aliases, id: \.self) { alias in
                                Text("• \(alias)")
                                    .font(.subheadline)
                            }
                        }
                    } // VStack
                    .padding([.leading, .bottom], 40)
                } // ScrollView
            } // ZStack
        } // GeometryReader
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(show: K.bbName, character: K.previewCharacter)
}
