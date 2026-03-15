//
//  QuizQuestion.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/03/26.
//

import Foundation

struct QuizQuestion: Codable {
    let question: String
    let options: [String]
    let correctAnswer: String
}