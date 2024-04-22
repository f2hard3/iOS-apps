//
//  GameViewModel.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/11.
//

import Foundation
import SwiftUI

@MainActor
class GameViewModel: ObservableObject {
    @Published var gameScore = 0
    @Published var questionScore = 5
    @Published var recentScores = [0, 0, 0]
    
    private var allQuestions: [Question] = []
    private var answerdQuestions: [Int] = []
    private var savePath: URL {
        if #available(iOS 16.0, *) {
            return FileManager.documentDirectory.appending(path: "SavedScores")
        } else {
            return FileManager.documentDirectory.appendingPathComponent("SavedScores")
        }
    }
    
    
    
    var filteredQuestions: [Question] = []
    var currentQuestion = K.previewQuestion
    var answers: [String] = []
    
    var correctAnswer: String {
        currentQuestion.answers.first { $0.value }!.key
    }
    
    init() {
        decodeQuestions()
    }
    
    private func decodeQuestions() {
        guard let url = Bundle.main.url(forResource: "trivia", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            allQuestions = try JSONDecoder().decode([Question].self, from: data)
            filteredQuestions = allQuestions
        } catch {
            print("Error decoding Json data: \(error)")
        }
    }
    
    func filterQuestions(to books: [Int]) {
        filteredQuestions = allQuestions.filter { books.contains($0.book) }
    }
    
    func newQuestion() {
        guard var potentialQuestion = filteredQuestions.randomElement() else { return }
        
        if answerdQuestions.count == filteredQuestions.count {
            answerdQuestions = []
        }
        
        while answerdQuestions.contains(potentialQuestion.id) {
            guard let nextQuestion = filteredQuestions.randomElement() else { return }
            potentialQuestion = nextQuestion
        }
        
        currentQuestion = potentialQuestion
        
        answers = []
        for answer in currentQuestion.answers.keys {
            answers.append(answer)
        }
        answers.shuffle()
        
        questionScore = 5
    }
    
    func correct() {
        answerdQuestions.append(currentQuestion.id)
        
        withAnimation {
            gameScore += questionScore
        }
    }
    
    func startGame() {
        gameScore = 0
        questionScore = 5
        answerdQuestions = []
    }
    
    func endGame() {
        recentScores.remove(at: 2)
        recentScores.insert(gameScore, at: 0)
        
        saveScores()
    }
    
    private func saveScores() {
        do {
            let data = try JSONEncoder().encode(recentScores)
            try data.write(to: savePath)
        } catch {
            print("Unable to save data: \(error)")
        }
    }
    
    func loadScores() {
        do {
            let data = try Data(contentsOf: savePath)
            recentScores = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            recentScores = [0, 0, 0]
        }
    }
}
