//
//  QuizQuestionCell.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/03/26.
//

import UIKit

class QuizQuestionCell: UITableViewCell {
    
    static let identifier = "QuizQuestionCell"
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(selectionIndicator)
        contentView.addSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            selectionIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectionIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectionIndicator.widthAnchor.constraint(equalToConstant: 20),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 20),
            
            optionLabel.leadingAnchor.constraint(equalTo: selectionIndicator.trailingAnchor, constant: 16),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            optionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            optionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    func configure(with option: String, isSelected: Bool) {
        optionLabel.text = option
        selectionIndicator.isHidden = !isSelected
        if isSelected {
            backgroundColor = .systemBlue.withAlphaComponent(0.1)
        } else {
            backgroundColor = .secondarySystemBackground
        }
    }
}