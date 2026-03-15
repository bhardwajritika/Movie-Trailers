//
//  QuizIntroViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/03/26.
//

import UIKit

class QuizIntroViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🎥 Movie Quiz Challenge 🎥"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .label
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🎬 Start Game 🎬", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.systemBlue.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupRulesText()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rulesTextView)
        contentView.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            rulesTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            rulesTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rulesTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: rulesTextView.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        startButton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
    }
    
    private func setupRulesText() {
        let rulesText = """
        🎬 How to Play:
        
        • 🎭 Identify 50 famous movie quotes
        • ⏰ 20 seconds per question - think fast!
        • ❌ Wrong answer or timeout = lose a life
        
        ❤️ Lives: Start with 3 hearts, game over when empty
        
        🔥 Streak Bonuses: Chain correct answers!
        - 3+ in a row: 2x points multiplier
        - 5+ in a row: 3x points multiplier
        
        ⏱️ Countdown Timer: Watch the clock - don't let it reach zero!
        
        🏆 Objective: Complete all questions and achieve the highest score!
        """
        
        let attributedText = NSMutableAttributedString(string: rulesText, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ])
        let boldFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let blueColor = UIColor.systemBlue
        
        let headers = ["🎬 How to Play:", "❤️ Lives:", "🔥 Streak Bonuses:", "⏱️ Countdown Timer:", "🏆 Objective:"]
        
        for header in headers {
            let range = (rulesText as NSString).range(of: header)
            if range.location != NSNotFound {
                attributedText.addAttribute(.font, value: boldFont, range: range)
                attributedText.addAttribute(.foregroundColor, value: blueColor, range: range)
            }
        }
        
        // Add some paragraph styling
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        rulesTextView.attributedText = attributedText
    }
    
    @objc private func startGameTapped() {
        let quizVC = QuizViewController()
        navigationController?.pushViewController(quizVC, animated: true)
    }
}