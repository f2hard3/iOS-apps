//
//  ContentView.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/08.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var game: GameViewModel
    
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewsIn = false
    
    @State private var showInstructions = false
    @State private var showSettings = false
    @State private var playGame = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .offset(x: moveBackgroundImage ? geo.size.width / 1.1 : -geo.size.width / 1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                
                VStack {
                    Group {
                        if animateViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                
                                Text("HP")
                                    .font(.custom(K.hpFont, size: 72))
                                    .padding(.bottom, -48)
                                
                                Text("Trivia")
                                    .font(.custom(K.hpFont, size: 56))
                            } // VStack
                            .padding(.top, 72)
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(.easeOut(duration: 0.8).delay(2), value: animateViewsIn)
                    
                    Spacer()
                    
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Text("Recent Scores")
                                    .font(.title2)
                                
                                ForEach(game.recentScores, id: \.hashValue) {
                                    Text(String($0))
                                }
                            } // VStack
                            .font(.title3)
                            .padding()
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.8))
                            .clipShape(.rect(cornerRadius: 16))
                            .transition(.opacity)
                        }
                    }
                    .animation(.linear(duration: 1.2).delay(4), value: animateViewsIn)
                    
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Group {
                            if animateViewsIn {
                                Button {
                                    showInstructions.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 4)
                                }
                                .transition(.offset(x: -geo.size.width / 4))
                            }
                        }
                        .animation(.easeOut(duration: 0.8).delay(2.8), value: animateViewsIn)
                        .sheet(isPresented: $showInstructions) {
                            Instructions()
                        }
                        
                        Spacer()
                        
                        Group {
                            if animateViewsIn {
                                Button {
                                    filterQuestions()
                                    game.startGame()
                                    playGame.toggle()
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 48)
                                        .background(store.books.contains(.active) ? .brown : .gray)
                                        .clipShape(.rect(cornerRadius: 8))
                                        .shadow(radius: 4)
                                }
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.2).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height / 4))
                            }
                        }
                        .animation(.easeOut(duration: 0.8).delay(2), value: animateViewsIn)
                        .fullScreenCover(isPresented: $playGame, content: {
                            GamePlay()
                                .onAppear {
                                    audioPlayer.setVolume(0, fadeDuration: 2)
                                }
                                .onDisappear {
                                    audioPlayer.setVolume(1, fadeDuration: 3)
                                }
                        })
                        .disabled(store.books.contains(.active) ? false : true)
                        
                        Spacer()
                        
                        Group {
                            if animateViewsIn {
                                Button {
                                    showSettings.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 4)
                                }
                                .transition(.offset(x: geo.size.width / 4))
                            }
                        }
                        .animation(.easeOut(duration: 0.8).delay(2.8), value: animateViewsIn)
                        .sheet(isPresented: $showSettings) {
                            Settings()
                        }
                        
                        Spacer()
                    } // HStack
                    .frame(width: geo.size.width)
                    
                    Group {
                        if animateViewsIn && !store.books.contains(.active){
                            Text("No questions available. Go to settings.⬆️")
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                        }
                    }
                    .animation(.easeIn(duration: 2.8), value: animateViewsIn)
                    
                    Spacer()
                } // VStack
            } // ZStack
            .frame(width: geo.size.width, height: geo.size.height)
            .padding(.top)
        } // GeometryReader
        .ignoresSafeArea()
        .onAppear {
            playAudio()
            animateViewsIn = true
        }
    } // body
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        
        if #available(iOS 16.0, *) {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        } else {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    private func filterQuestions() {
        let books = store.books.enumerated().compactMap { index, status in
            status == .active
            ? index + 1
            : nil
        }
        
        game.filterQuestions(to: books)
        game.newQuestion()
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
        .environmentObject(GameViewModel())
}
