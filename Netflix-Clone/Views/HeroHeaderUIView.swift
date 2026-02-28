//
//  HeroHeaderUIView.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 09/01/26.
//

import UIKit

protocol HeroHeaderUIViewDelegate: AnyObject {
    func heroHeaderViewDidTapPlay(_ header: HeroHeaderUIView, viewModel: TitlePreviewViewModel)
    func heroHeaderViewDidTapDownload(_ header: HeroHeaderUIView, title: Title)
}

class HeroHeaderUIView: UIView {
    
    weak var delegate: HeroHeaderUIViewDelegate?
    private var title: Title?
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        
        addSubview(playButton)
        addSubview(downloadButton)
        addConstraints()
        addGradient()
        playButton.backgroundColor = .gray
        downloadButton.backgroundColor = .gray
        
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(didTapDownload), for: .touchUpInside)
        
    }
    
    @objc private func didTapPlay() {
        guard let title = title else { return }
        let titleName = title.original_title ?? title.original_name ?? ""
        
        APICaller.shared.getMovies(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let video):
                let viewModel = TitlePreviewViewModel(
                    title: titleName,
                    youtubeView: video,
                    titleOverview: title.overview ?? ""
                )
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.delegate?.heroHeaderViewDidTapPlay(self, viewModel: viewModel)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapDownload() {
        guard let title = title else { return }
        delegate?.heroHeaderViewDidTapDownload(self, title: title)
    }
    
    private let gradientLayer = CAGradientLayer()
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        gradientLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func configure(with title: Title) {
        self.title = title
        
        let posterPath = title.poster_path ?? ""
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
        
        heroImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: "heroImage")
        )
    }
    
        
    private func addConstraints() {
        NSLayoutConstraint.activate([
            playButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 115),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            
            downloadButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 115),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}


