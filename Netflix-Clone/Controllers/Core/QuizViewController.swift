//
//  QuizViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/03/26.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var currentQuestion: QuizQuestion?
    private var selectedOption: String?
    private var progressTimer: Timer?
    private var countdownTimer: Timer?
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let livesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let streakLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countdownView: CircularProgressView = {
        let view = CircularProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let optionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuizQuestionCell.self, forCellReuseIdentifier: QuizQuestionCell.identifier)
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Answer", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Next question loading..."
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progressTintColor = .systemBlue
        progressBar.trackTintColor = .systemGray4
        progressBar.isHidden = true
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Movie Quiz"
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startQuiz()
    }
    
    deinit {
        progressTimer?.invalidate()
        countdownTimer?.invalidate()
    }
    
    private func setupUI() {
        view.addSubview(progressLabel)
        view.addSubview(scoreLabel)
        view.addSubview(livesLabel)
        view.addSubview(streakLabel)
        view.addSubview(countdownView)
        view.addSubview(questionLabel)
        view.addSubview(optionsTableView)
        view.addSubview(submitButton)
        view.addSubview(feedbackLabel)
        view.addSubview(loadingLabel)
        view.addSubview(progressView)
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            // Top row: Lives | Progress | Score
            livesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            livesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Second row: Streak | Countdown
            streakLabel.topAnchor.constraint(equalTo: livesLabel.bottomAnchor, constant: 10),
            streakLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            countdownView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            countdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countdownView.widthAnchor.constraint(equalToConstant: 60),
            countdownView.heightAnchor.constraint(equalToConstant: 60),
            
            
            questionLabel.topAnchor.constraint(equalTo: streakLabel.bottomAnchor, constant: 30),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: countdownView.leadingAnchor, constant: -20),
            
            optionsTableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            optionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            optionsTableView.heightAnchor.constraint(equalToConstant: 250),
            
            submitButton.topAnchor.constraint(equalTo: optionsTableView.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            feedbackLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            feedbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadingLabel.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 30),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressView.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 10),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 200),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    private func startQuiz() {
        QuizManager.shared.startNewQuiz()
        loadNextQuestion()
    }
    
    private func loadNextQuestion() {
        // Cancel any ongoing timers
        progressTimer?.invalidate()
        progressTimer = nil
        stopCountdownTimer()
        
        currentQuestion = QuizManager.shared.getCurrentQuestion()
        selectedOption = nil
        feedbackLabel.isHidden = true
        loadingLabel.isHidden = true
        progressView.isHidden = true
        
        if let question = currentQuestion {
            updateUI(with: question)
            startCountdownTimer()
        } else {
            showResults()
        }
    }
    
    private func updateUI(with question: QuizQuestion) {
        let progress = QuizManager.shared.getProgress()
        progressLabel.text = "Question \(progress.current) / \(progress.total)"
        scoreLabel.text = "Score: \(QuizManager.shared.getScore())"
        
        // Update lives display
        let lives = QuizManager.shared.getLives()
        livesLabel.text = "❤️".repeating(lives)
        
        // Update streak display
        let streak = QuizManager.shared.getStreak()
        if streak > 0 {
            streakLabel.text = "🔥 \(streak)"
        } else {
            streakLabel.text = ""
        }
        
        // Update countdown
        let timeRemaining = QuizManager.shared.getTimeRemaining()
        let progressValue = CGFloat(timeRemaining / 20.0)
        countdownView.setProgress(progressValue, timeRemaining: timeRemaining)
        
        
        questionLabel.text = question.question
        optionsTableView.reloadData()
        submitButton.isEnabled = false
        submitButton.backgroundColor = .systemGray
    }
    
    private func startCountdownTimer() {
        stopCountdownTimer() // Ensure no duplicate timers
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            let timeRemaining = QuizManager.shared.getTimeRemaining()
            if timeRemaining <= 0 {
                self.stopCountdownTimer()
                // Time's up - auto-submit wrong answer
                self.submitAnswer("")
                return
            }
            
            // Update time
            QuizManager.shared.updateTimeRemaining(timeRemaining - 0.1)
            
            // Update UI
            let progressValue = CGFloat(timeRemaining / 10.0)
            self.countdownView.setProgress(progressValue, timeRemaining: timeRemaining)
        }
    }
    
    private func stopCountdownTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    private func showResults() {
        // Stop all timers
        stopCountdownTimer()
        progressTimer?.invalidate()
        progressTimer = nil
        
        QuizManager.shared.saveBestScore()
        let score = QuizManager.shared.getScore()
        let total = QuizManager.shared.getProgress().total
        let resultVC = QuizResultViewController(score: score, total: total)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    private func showGameOver() {
        // Stop all timers
        stopCountdownTimer()
        progressTimer?.invalidate()
        progressTimer = nil
        
        QuizManager.shared.saveBestScore()
        let score = QuizManager.shared.getScore()
        let total = QuizManager.shared.getProgress().total
        let gameOverVC = QuizResultViewController(score: score, total: total, isGameOver: true)
        navigationController?.pushViewController(gameOverVC, animated: true)
    }
    
    @objc private func submitTapped() {
        guard let selected = selectedOption else { return }
        submitAnswer(selected)
    }
        
    private func submitAnswer(_ answer: String) {
        // Stop countdown timer
        stopCountdownTimer()
        
        // Disable button
        submitButton.isEnabled = false
        submitButton.backgroundColor = .systemGray
        
        let isCorrect = QuizManager.shared.submitAnswer(answer)
        
        feedbackLabel.isHidden = false
        if isCorrect {
            feedbackLabel.text = "✅ Correct!"
            feedbackLabel.textColor = .systemGreen
        } else {
            feedbackLabel.text = "❌ Wrong! Correct: \(currentQuestion?.correctAnswer ?? "")"
            feedbackLabel.textColor = .systemRed
        }
        
        // Animate feedback
        feedbackLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3) {
            self.feedbackLabel.transform = .identity
        }
        
        // Check if game is over due to lives
        if QuizManager.shared.isGameOver() {
            // Show game over screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showGameOver()
            }
        } else {
            // Show progress bar and animate
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.loadingLabel.isHidden = false
                self.progressView.isHidden = false
                self.progressView.progress = 0
                
                // Animate progress over 2 seconds using timer
                let duration: TimeInterval = 2.0
                let steps = 20
                let stepDuration = duration / TimeInterval(steps)
                var currentStep = 0
                
                self.progressTimer = Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true) { timer in
                    currentStep += 1
                    let progress = Float(currentStep) / Float(steps)
                    self.progressView.progress = progress
                    
                    if currentStep >= steps {
                        timer.invalidate()
                        self.progressTimer = nil
                        
                        // Hide progress elements and load next question
                        self.loadingLabel.isHidden = true
                        self.progressView.isHidden = true
                        self.loadNextQuestion()
                    }
                }
            }
        }
    }
    
// MARK: - Circular Progress View
class CircularProgressView: UIView {
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Track layer (background circle)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - 10
        let trackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = UIColor.systemGray4.cgColor
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)
        
        // Progress layer
        progressLayer.path = trackPath.cgPath
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.lineWidth = 6
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 1.0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
        
        // Time label
        timeLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        timeLabel.textAlignment = .center
        timeLabel.textColor = .label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setProgress(_ progress: CGFloat, timeRemaining: TimeInterval) {
        progressLayer.strokeEnd = progress
        timeLabel.text = "\(Int(ceil(timeRemaining)))"
        
        // Change color based on time remaining
        if timeRemaining <= 3 {
            progressLayer.strokeColor = UIColor.systemRed.cgColor
        } else if timeRemaining <= 6 {
            progressLayer.strokeColor = UIColor.systemOrange.cgColor
        } else {
            progressLayer.strokeColor = UIColor.systemBlue.cgColor
        }
    }
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionCell.identifier, for: indexPath) as? QuizQuestionCell,
              let question = currentQuestion else {
            return UITableViewCell()
        }
        
        let option = question.options[indexPath.row]
        let isSelected = option == selectedOption
        cell.configure(with: option, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> Float {
        return 50
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let question = currentQuestion else { return }
        selectedOption = question.options[indexPath.row]
        submitButton.isEnabled = true
        submitButton.backgroundColor = .systemBlue
        tableView.reloadData()
    }
}
