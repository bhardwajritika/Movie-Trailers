//
//  QuizResultViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/03/26.
//

import UIKit

class QuizResultViewController: UIViewController {
    
    private let score: Int
    private let total: Int
    private let isGameOver: Bool
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bestScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Again", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(score: Int, total: Int, isGameOver: Bool = false) {
        self.score = score
        self.total = total
        self.isGameOver = isGameOver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        view.addSubview(resultLabel)
        view.addSubview(scoreLabel)
        view.addSubview(bestScoreLabel)
        view.addSubview(playAgainButton)
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bestScoreLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            bestScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playAgainButton.topAnchor.constraint(equalTo: bestScoreLabel.bottomAnchor, constant: 40),
            playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playAgainButton.widthAnchor.constraint(equalToConstant: 200),
            playAgainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        playAgainButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        if isGameOver {
            resultLabel.text = "💔 Game Over!"
            resultLabel.textColor = .systemRed
            playAgainButton.setTitle("Try Again", for: .normal)
        } else {
            let percentage = Double(score) / Double(total) * 100
            if percentage >= 80 {
                resultLabel.text = "🎉 Excellent!"
                resultLabel.textColor = .systemGreen
            } else if percentage >= 60 {
                resultLabel.text = "👍 Good Job!"
                resultLabel.textColor = .systemBlue
            } else {
                resultLabel.text = "😊 Keep Trying!"
                resultLabel.textColor = .systemOrange
            }
        }
        
        scoreLabel.text = "Your Score: \(score) / \(total)"
        
        let bestScore = QuizManager.shared.getBestScore()
        bestScoreLabel.text = "Best Score: \(bestScore)"
    }
    
    @objc private func playAgainTapped() {
        QuizManager.shared.startNewQuiz()
        navigationController?.popViewController(animated: true)
    }
}