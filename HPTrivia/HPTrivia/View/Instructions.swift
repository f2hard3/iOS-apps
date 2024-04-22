//
//  Instructions.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/09.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Image(.appiconwithradius)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 152)
                    .padding(.top)
                
                ScrollView {
                    Text("How To Play")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Welcome to HP Trivia! In this game, you will be asked random questions from the HP books and you must guess the right answer or you will lose points!😱")
                            .padding([.horizontal, .bottom])
                        
                        Text("Each questions is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                            .padding([.horizontal, .bottom])
                        
                        Text("If you are struggling with a question, there is an option to reveal a hint or reveal the book that answers the question. But be aware! Using these also minuses 1 point each.")
                            .padding([.horizontal, .bottom])
                        
                        Text("When you select the correct answer, you will be awarded all the points left for that question and they will be added to your total score.")
                            .padding(.horizontal)
                    } // VStack
                    .font(.title3)
                    
                    Text("Good Luck!")
                        .font(.title)
                } // ScrollView
                .foregroundStyle(.black)
                
                Button("Done") {
                    dismiss()
                }
                .doneButton()
            } // VStack
        } // ZStack
    }
}

#Preview {
    Instructions()
}
