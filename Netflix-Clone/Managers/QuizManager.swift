//
//  QuizManager.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/03/26.
//

import Foundation

class QuizManager {
    static let shared = QuizManager()
    
    private var allQuestions: [QuizQuestion] = []
    private var currentQuestions: [QuizQuestion] = []
    private var currentIndex = 0
    private var score = 0
    private var streak = 0
    private var lives = 3
    private var timeRemaining: TimeInterval = 10.0
    private var gameOver = false
    
    private init() {
        loadQuestions()
    }
    
    private func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "quiz_questions", withExtension: "json") else {
            print("Quiz questions JSON not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            allQuestions = try JSONDecoder().decode([QuizQuestion].self, from: data)
        } catch {
            print("Error loading quiz questions: \(error)")
        }
    }
    
    func startNewQuiz() {
        // Create up to 50 questions by cycling through available questions
        var questions: [QuizQuestion] = []
        let totalQuestions = min(50, allQuestions.count * 3) // Allow up to 3 cycles
        
        for i in 0..<totalQuestions {
            let questionIndex = i % allQuestions.count
            questions.append(allQuestions[questionIndex])
        }
        
        currentQuestions = questions.shuffled()
        currentIndex = 0
        score = 0
        streak = 0
        lives = 3
        timeRemaining = 20.0
        gameOver = false
    }
    
    func getCurrentQuestion() -> QuizQuestion? {
        guard currentIndex < currentQuestions.count else { return nil }
        return currentQuestions[currentIndex]
    }
    
    func getProgress() -> (current: Int, total: Int) {
        return (currentIndex + 1, currentQuestions.count)
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getLives() -> Int {
        return lives
    }
    
    func getStreak() -> Int {
        return streak
    }
    
    func getTimeRemaining() -> TimeInterval {
        return timeRemaining
    }
    
    func updateTimeRemaining(_ time: TimeInterval) {
        timeRemaining = max(0, time)
    }
    
    func isGameOver() -> Bool {
        return gameOver || lives <= 0
    }
    
    func submitAnswer(_ answer: String) -> Bool {
        guard let question = getCurrentQuestion(), !gameOver else { return false }
        
        let isCorrect = answer == question.correctAnswer
        
        if isCorrect {
            streak += 1
            var points = 1
            
            // Streak bonuses
            if streak >= 5 {
                points = 3 // 3x points for 5+ streak
            } else if streak >= 3 {
                points = 2 // 2x points for 3-4 streak
            }
            
            score += points
        } else {
            streak = 0
            lives -= 1
            
            if lives <= 0 {
                gameOver = true
            }
        }
        
        currentIndex += 1
        timeRemaining = 20.0 // Reset timer for next question
        
        return isCorrect
    }
    
    func isQuizComplete() -> Bool {
        return currentIndex >= currentQuestions.count
    }
    
    func getBestScore() -> Int {
        return UserDefaults.standard.integer(forKey: "bestScore")
    }
    
    func saveBestScore() {
        let currentBest = getBestScore()
        if score > currentBest {
            UserDefaults.standard.set(score, forKey: "bestScore")
        }
    }
}