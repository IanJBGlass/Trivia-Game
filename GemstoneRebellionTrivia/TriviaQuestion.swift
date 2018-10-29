//
//  TriviaQuestion.swift
//  GemstoneRebellionTrivia
//
//  Created by Jacob Glass on 10/19/18.
//  Copyright © 2018 Jacob Glass. All rights reserved.
//

import Foundation

class TriviaQuestion {
    let question: String
    
    
    let answers: [String]
    
   
    let correctAnswerIndex: Int
    
    
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
    init(question: String, answers: [String], correctAnswerIndex: Int){
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
    
}

































