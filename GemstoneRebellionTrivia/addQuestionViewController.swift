//
//  addQuestionViewController.swift
//  GemstoneRebellionTrivia
//
//  Created by Jacob Glass on 10/26/18.
//  Copyright © 2018 Jacob Glass. All rights reserved.
//

import UIKit

class addQuestionViewController: UIViewController {

    @IBOutlet weak var newQuestionTextField: UITextField!
    
    
    
    @IBOutlet weak var AnswerATextField: UITextField!
    
    
    
    @IBOutlet weak var AnswerBTextField: UITextField!
    
    
    
    @IBOutlet weak var AnswerCTextField: UITextField!
    
  
    
    @IBOutlet weak var AnswerDTextField: UITextField!
   
    
    
    @IBOutlet weak var CorrectAnswerController: UISegmentedControl!
    
    
    
    var newTrivia: TriviaQuestion?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func CancelButtonTapped(_ sender: Any) {
   self.performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }

    @IBAction func AddButtonTapped(_ sender: Any) {
        guard
            let question = newQuestionTextField.text, !question.isEmpty,
            let a = AnswerATextField.text, !a.isEmpty,
            let b = AnswerBTextField.text, !b.isEmpty,
            let c = AnswerCTextField.text, !c.isEmpty,
            let d = AnswerDTextField.text, !d.isEmpty
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields, or press cancel to return to quiz.", preferredStyle: UIAlertController.Style.alert)
                let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {UIAlertAction in}
                errorAlert.addAction(dismissAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
        }
        newTrivia = TriviaQuestion(question: question, answers: [a,b,c,d], correctAnswerIndex: CorrectAnswerController.selectedSegmentIndex)
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? QuizViewController,
            let newTriviaQuestion = newTrivia
            else {return}
        destinationVC.questions.append(newTriviaQuestion)
        destinationVC.resetGame()
    }
}











