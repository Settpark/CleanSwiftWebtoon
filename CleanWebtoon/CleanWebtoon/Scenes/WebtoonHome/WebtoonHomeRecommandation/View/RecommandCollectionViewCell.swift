//
//  RecommandCollectionViewCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/17.
//

import UIKit

class RecommandCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel
    
    override init(frame: CGRect) {
        titleLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 23)
            label.textAlignment = .natural
            label.textColor = .white
            label.sizeToFit()
            return label
        }()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        self.contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureView(title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0...255)/255, green: CGFloat.random(in: 0...255)/255, blue: CGFloat.random(in: 0...255)/255, alpha: 1)
        }
    }
}
