//
//  ViewController.swift
//  Project2
//
//  Created by Andrew Kwun on 2020/12/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1;
        button2.layer.borderWidth = 1;
        button3.layer.borderWidth = 1;
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        count += 1
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) [\(score)]"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if (sender.tag == correctAnswer) {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong!"
            score -= 1
        }
        
        if count < 10 {
            let ac: UIAlertController
            if title.hasPrefix("W") {
                let str = "It's the flag of \(countries[sender.tag].uppercased()) \n Your score is \(score)"
                ac = UIAlertController(title: title, message: str, preferredStyle: .alert)
            } else {
                ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            }
            ac.addAction(UIAlertAction(title: "continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let finalAlert = UIAlertController(title: "Game Over!", message: "Your score is \(score)", preferredStyle: .alert)
            finalAlert.addAction(UIAlertAction(title: "Start New Game", style: .default, handler: startNewGame))
            present(finalAlert, animated: true)
        }
    }
    
    func startNewGame(action: UIAlertAction) {
        score = 0;
        count = 0;
        
        askQuestion(action: nil)
    }
}
