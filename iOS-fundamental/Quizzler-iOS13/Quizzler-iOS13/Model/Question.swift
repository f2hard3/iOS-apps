import Foundation

struct Question {
    let text: String
    let choices: [String]
    let correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.text = q
        self.choices = a
        self.correctAnswer = correctAnswer
    }
}
