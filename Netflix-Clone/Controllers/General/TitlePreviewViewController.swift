//
//  TitlePreviewViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 17/01/26.
//

import UIKit
import WebKit
import YouTubeiOSPlayerHelper

//-----------------------------------------------
//class TitlePreviewViewController: UIViewController {
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "harry potter"
//        return label
//    }()
//    
//    
//    private let overviewLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 17, weight: .regular)
//        label.numberOfLines = 0
//        label.text = "This is the best movie to watch for kids."
//        return label
//    }()
//    
//    
//    private let downloadButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Download", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = true
//        return button
//    }()
//    
//    private let webView: WKWebView  = {
//        let config = WKWebViewConfiguration()
//        config.allowsInlineMediaPlayback = true
//        config.mediaTypesRequiringUserActionForPlayback = []
//        let webView = WKWebView(frame: .zero, configuration: config)
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        return webView
//    } ()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        
//        view.addSubview(webView)
//        view.addSubview(titleLabel)
//        view.addSubview(overviewLabel)
//        view.addSubview(downloadButton)
//        
//        configureConstraints()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    private func configureConstraints() {
//        NSLayoutConstraint.activate([
//            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            webView.heightAnchor.constraint(equalToConstant: 300),
//            
//            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            
//            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
//            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
//            downloadButton.widthAnchor.constraint(equalToConstant: 140),
//            downloadButton.heightAnchor.constraint(equalToConstant: 40)
//            
//            
//            
//        ])
//    }
    
    
//    func configure(with model: TitlePreviewViewModel) {
//        titleLabel.text = model.title
//        overviewLabel.text = model.titleOverview
//        let query = model.youtubeView.id.videoId
//        
//        let config = WKWebViewConfiguration()
//        config.allowsInlineMediaPlayback = true
//        config.mediaTypesRequiringUserActionForPlayback = []
//        
//        let webView = WKWebView(frame: .zero, configuration: config)
//        
//        guard let url = URL(string: "https://www.youtube.com/embed/\(query)?playsinline=1&origin=https://www.youtube.com") else { return }
//        
//        print(url)
//        
//        webView.load(URLRequest(url: url))
//    }
//    
//    func configure(with model: TitlePreviewViewModel) {
//        titleLabel.text = model.title
//        overviewLabel.text = model.titleOverview
//        
//        let config = WKWebViewConfiguration()
//        config.allowsInlineMediaPlayback = true
//        config.mediaTypesRequiringUserActionForPlayback = []
//        
//        let videoId = model.youtubeView.id.videoId
//        
//        let html = """
//    <!DOCTYPE html>
//    <html>
//    <head>
//    <meta name="viewport" content="width=device-width, initial-scale=1.0">
//    <style>
//    body { margin: 0; padding: 0; background-color: black; }
//    iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
//    </style>
//    </head>
//    <body>
//    <iframe
//        src="https://www.youtube.com/embed/\(videoId)?playsinline=1"
//        frameborder="0"
//        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
//        allowfullscreen>
//    </iframe>
//    </body>
//    </html>
//    """
//        
//        webView.loadHTMLString(html, baseURL: nil)
//        webView.isUserInteractionEnabled = true
//    }
//
//
//
//}

// <iframe width="848" height="477" src="https://www.youtube.com/embed/V4TJKSEftkU" title="Mardaani 3 | Official Trailer | Rani Mukerji | Abhiraj Minawala | Releasing 30 Jan 2026" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>


// <iframe width="848" height="477" src="https://www.youtube.com/embed/n0pqP6ClcE8" title="RENTAL FAMILY | Official Trailer | Searchlight Pictures" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>



//--------------------------------------


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
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private func setupUI() {
        view.addSubview(playerView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
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
            
            // Download button
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
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
