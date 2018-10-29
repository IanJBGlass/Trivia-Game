//
//  QuizViewController.swift
//  GemstoneRebellionTrivia
//
//  Created by Jacob Glass on 10/26/18.
//  Copyright © 2018 Jacob Glass. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    
    //Initialize array to hold our trivia questions
    var questions = [TriviaQuestion]()
    var questionsPlaceholder = [TriviaQuestion]()
    
    var currentIndex: Int!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                questionLabel.text = currentQuestion.question
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColors()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateQuestions()
        getNewQuestion()
    }
    
    //Populate initial questions array on first run of app
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "How it do?", answers: ["it do", "it dont", "good", "bad"], correctAnswerIndex: 0)
        let question2 = TriviaQuestion(question: "How do magnets work", answers: ["General Relativity", "Ungeneral Relativity", "Magic", "Ferromagnetism"], correctAnswerIndex: 3)
        let question3 = TriviaQuestion(question: "What is the best selling game of all time", answers: ["Vectors", "Minecraft", "tetris", "Pong"], correctAnswerIndex: 2)
        questions = [question1, question2, question3]
    }
    
    func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else {
            showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        let endAlert = UIAlertController(title: "Trivia Results", message: "Game over! Your score was \(score) out of \(questionsPlaceholder.count)", preferredStyle: UIAlertController.Style.alert)
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default) { UIAlertAction in
            self.resetGame()
        }
        
        endAlert.addAction(resetAction)
        self.present(endAlert, animated: true, completion: nil)
    }
    
    let backgroundColors = [
        UIColor(red: 255/255, green: 127/255, blue: 80/255, alpha: 1.0),
        UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 1.0),
        UIColor(red: 127/255, green: 255/255, blue: 0/255, alpha: 1.0),
        UIColor(red: 127/255, green: 255/255, blue: 212/255, alpha: 1.0),
        UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0)
    ]
    
    func setNewColors() {
        let randomNumber = Int.random(in: 1...100)
        let randomColorA = backgroundColors[randomNumber % 4]
        let randomColorB = backgroundColors[(randomNumber + 1) % 4]
        let randomColorC = backgroundColors[(randomNumber + 2) % 4]
        let randomColorD = backgroundColors[(randomNumber + 3) % 4]
        
        answerAButton.backgroundColor = randomColorA
        answerBButton.backgroundColor = randomColorB
        answerCButton.backgroundColor = randomColorC
        answerDButton.backgroundColor = randomColorD
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        if currentQuestion.correctAnswerIndex == sender.tag {
            score += 1
            showCorrectAnswerAlert()
            //Need to fill out showCorrecrtAnswerAlert
        } else {
            showIncorrectAnswerAlert()
        }
    }
    
    func showIncorrectAnswerAlert() {
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) is the answer we were looking for! Bad!!!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "...Sorry", style: UIAlertAction.Style.default) { UIAlertAction in
            print(self.currentIndex)
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okayAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    func showCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) is the correct answer! Good work!!!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you!", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAlert.addAction(okayAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    func resetGame() {
        score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue){}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
