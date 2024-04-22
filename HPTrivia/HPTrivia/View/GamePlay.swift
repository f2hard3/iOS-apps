//
//  GamePlay.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/09.
//

import SwiftUI
import AVKit

struct GamePlay: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var game: GameViewModel
    
    @Namespace private var namespace
    
    @State private var musicPlayer: AVAudioPlayer!
    @State private var soundEffectPlayer: AVAudioPlayer!
    
    @State private var animationViewsIn = false
    @State private var hintWiggle = false
    
    @State private var tappedCorrectAnswer = false
    @State private var wrongAnswersTapped: [Int] = []
    
    @State private var scaleNextButton = false
    @State private var movePointsToScore = false
    
    @State private var revealHint = false
    @State private var revealBook = false
        
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.06)
                    .overlay(Rectangle().opacity(0.8))
                
                VStack {
                    HStack {
                        // MARK: Controls
                        Button("End Game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(.red.opacity(0.6))
                        
                        Spacer()
                        
                        Text("Score: \(game.gameScore)")
                    } // HStack
                    .padding()
                    .padding(.vertical, 32)
                    
                    // MARK: Question
                    VStack {
                        if animationViewsIn {
                            Text(game.currentQuestion.question)
                                .font(.custom(K.hpFont, size: 48))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.scale)
                                .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        }
                    }
                    .animation(.easeInOut(duration: animationViewsIn ? 1.6 : 0), value: animationViewsIn)
                    
                    Spacer()
                    
                    // MARK: Hints
                    HStack {
                        Group {
                            if animationViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 96)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(hintWiggle ? -12 : -16))
                                    .padding()
                                    .padding(.leading, 24)
                                    .transition(.offset(x: -geo.size.width / 2))
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.1).repeatCount(8).delay(5).repeatForever()) {
                                            hintWiggle = true
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealHint = true
                                        }
                                        
                                        playSound(of: .flip)
                                        game.questionScore -= 1
                                    }
                                    .rotation3DEffect(.degrees(revealHint ? 1440: 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .opacity(revealHint ? 0 : 1)
                                    .offset(x: revealHint ? geo.size.width / 2 : 0)
                                    .overlay {
                                        Text(game.currentQuestion.hint)
                                            .padding(.leading, 32)
                                            .minimumScaleFactor(0.4)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.32 : 1)
                                    }
                                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                    .disabled(tappedCorrectAnswer)
                            }
                        }
                        .animation(.easeOut(duration: animationViewsIn ? 1.6 : 0).delay(animationViewsIn ? 2.4 : 0), value: animationViewsIn)
                        
                        Spacer()
                        
                        Group {
                            if animationViewsIn {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48)
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height: 100)
                                    .background(.cyan)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .rotationEffect(.degrees(hintWiggle ? 12 : 16))
                                    .padding()
                                    .padding(.trailing, 24)
                                    .transition(.offset(x: geo.size.width / 2))
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealBook = true
                                        }
                                        
                                        playSound(of: .flip)
                                        game.questionScore -= 1
                                    }
                                    .rotation3DEffect(.degrees(revealBook ? 1440: 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                                    .scaleEffect(revealBook ? 5 : 1)
                                    .opacity(revealBook ? 0 : 1)
                                    .offset(x: revealBook ? -geo.size.width / 2 : 0)
                                    .overlay {
                                        Image("hp\(game.currentQuestion.book)")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(.trailing, 32)
                                            .opacity(revealBook ? 1 : 0)
                                            .scaleEffect(revealBook ? 1.32 : 1)
                                    }
                                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                    .disabled(tappedCorrectAnswer)
                            }
                        }
                        .animation(.easeOut(duration: animationViewsIn ? 1.6 : 0).delay(animationViewsIn ? 2.4 : 0), value: animationViewsIn)
                    } // HStack
                    .padding(.bottom)
                    
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(Array(game.answers.enumerated()), id: \.offset) { i, answer in
                            if game.currentQuestion.answers[answer] == true {
                                VStack {
                                    if animationViewsIn && !tappedCorrectAnswer {
                                        Text(answer)
                                            .minimumScaleFactor(0.6)
                                            .multilineTextAlignment(.center)
                                            .padding(8)
                                            .frame(width: geo.size.width / 2.16, height: 80)
                                            .background(.green.opacity(0.6))
                                            .clipShape(.rect(cornerRadius: 24))
                                            .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 5)).combined(with: .opacity.animation(.easeOut(duration: 1))))
                                            .matchedGeometryEffect(id: "answer", in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeOut(duration: 1)) {
                                                    tappedCorrectAnswer = true
                                                }
                                                
                                                playSound(of: .correct)
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                                                    game.correct()
                                                }
                                            }
                                    }
                                } // VStack
                                .animation(.easeOut(duration: 0.8).delay(1.2), value: animationViewsIn)
                            } else {
                                VStack {
                                    if animationViewsIn {
                                        Text(answer)
                                            .minimumScaleFactor(0.6)
                                            .multilineTextAlignment(.center)
                                            .padding(8)
                                            .frame(width: geo.size.width / 2.16, height: 80)
                                            .background(wrongAnswersTapped.contains(i) ? .red.opacity(0.6) :.green.opacity(0.6))
                                            .clipShape(.rect(cornerRadius: 24))
                                            .transition(.scale)
                                            .onTapGesture {
                                                withAnimation(.easeOut(duration: 1)) {
                                                    wrongAnswersTapped.append(i)
                                                }
                                                
                                                playSound(of: .wrong)
                                                
                                                giveWrongFeedBack()
                                                
                                                game.questionScore -= 1
                                            }
                                            .scaleEffect(wrongAnswersTapped.contains(i) ? 0.8 : 1)
                                            .disabled(tappedCorrectAnswer || wrongAnswersTapped.contains(i))
                                            .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                    }
                                } // VStack
                                .animation(.easeOut(duration: animationViewsIn ? 0.8 : 0).delay(animationViewsIn ? 1.2 : 0), value: animationViewsIn)
                            }
                        } // ForEach
                    } // LazyVGrid
                    
                    Spacer()
                } // VStack
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
                
                // MARK: Celebration
                VStack {
                    Spacer()
                    Spacer()
                    
                    Group {
                        if tappedCorrectAnswer {
                            Text(String(game.questionScore))
                                .font(.largeTitle)
                                .transition(.offset(y: -geo.size.height / 4))
                                .offset(x: movePointsToScore ? geo.size.width / 2.4 : 0, y: movePointsToScore ? -geo.size.height / 12 : 0)
                                .opacity(movePointsToScore ? 0 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).delay(3)) {
                                        movePointsToScore = true
                                    }
                                }
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 2 : 0), value: tappedCorrectAnswer)
                    
                    Spacer()
                    VStack {
                        if tappedCorrectAnswer {
                            Text("Brilliant!")
                                .font(.custom(K.hpFont, size: 96))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height / 2)))
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 1: 0), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    if tappedCorrectAnswer {
                        Text(game.correctAnswer)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.4)
                            .padding()
                            .frame(width: geo.size.width / 2.16, height:80)
                            .background(.green.opacity(0.4))
                            .clipShape(.rect(cornerRadius: 24))
                            .scaleEffect(2)
                            .matchedGeometryEffect(id: "answer", in: namespace)
                    }
                        
                    Spacer()
                    Spacer()
                    
                    Group {
                        if tappedCorrectAnswer {
                            Button("Next Level >") {
                                animationViewsIn = false
                                tappedCorrectAnswer = false
                                revealHint = false
                                revealBook = false
                                movePointsToScore = false
                                wrongAnswersTapped = []
                                game.newQuestion()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    animationViewsIn = true
                                }
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                            .tint(.blue.opacity(0.4))
                            .font(.largeTitle)
                            .transition(.offset(y: geo.size.height / 2))
                            .scaleEffect(scaleNextButton ? 1.2 : 1)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.2).repeatForever()) {
                                    scaleNextButton.toggle()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 2.4 : 0).delay(tappedCorrectAnswer ? 2.4 : 0), value: tappedCorrectAnswer)
                    
                    Spacer()
                    Spacer()
                }
                .foregroundStyle(.white)
            } // ZStack
            .frame(width: geo.size.width, height: geo.size.height)
        } // GeometryReader
        .ignoresSafeArea()
        .onAppear {
            animationViewsIn = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                playMusic()
            }
        }
    } // body
    
    private func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        
        let i = Int.random(in: 0...3)
        
        let sound = Bundle.main.path(forResource: songs[i], ofType: "mp3")
        
        if #available(iOS 16.0, *) {
            musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        } else {
            musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        
        musicPlayer.volume = 0.1
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
    
    private func playSound(of resource: SoundEffect) {
        let sound = Bundle.main.path(forResource: resource.musicFile, ofType: "mp3")
        
        if #available(iOS 16.0, *) {
            musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        } else {
            musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        
        musicPlayer.play()
    }
    
    private func giveWrongFeedBack() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
} // GamePlay

#Preview {
    GamePlay()
        .environmentObject(GameViewModel())
}
