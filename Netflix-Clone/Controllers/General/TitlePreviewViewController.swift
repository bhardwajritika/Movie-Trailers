//
//  TitlePreviewViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 17/01/26.
//

import UIKit
import WebKit
import YouTubeiOSPlayerHelper



final class TitlePreviewViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let playerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let downloadButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Download", for: .normal)
//        button.backgroundColor = .systemRed
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    
    private func setupUI() {
        view.addSubview(playerView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
//        view.addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            
            // Trailer
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9/16),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Overview
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
//            // Download button
//            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
//            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            downloadButton.widthAnchor.constraint(equalToConstant: 140),
//            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    // MARK: - Public API (USED BY OTHER FILES)
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        let videoId = model.youtubeView.id.videoId
        
        // Netflix-style player config
        let playerVars: [String: Any] = [
            "playsinline": 1,
            "controls": 1,
            "modestbranding": 1,
            "rel": 0,
            "showinfo": 0
        ]
        
        playerView.load(
            withVideoId: videoId,
            playerVars: playerVars
        )
    }
}
