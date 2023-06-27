//
//  WebtoonListCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import UIKit

class WebtoonListCell: UICollectionViewCell {
    
    static var identifier = "webtoonListCell"
    
    private let mainImage: UIImageView
    private let webtoonTitle: UILabel
    private let author: UILabel
    private let ratingStar: UIImageView
    private let ratingScore: UILabel
    
    override init(frame: CGRect) {
        mainImage = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        webtoonTitle = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14, weight: .semibold)
            label.sizeToFit()
            return label
        }()
        author = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemGray3
            label.font = .systemFont(ofSize: 13)
            label.sizeToFit()
            return label
        }()
        ratingStar = {
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        ratingScore = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemGray3
            label.font = .systemFont(ofSize: 13)
            label.sizeToFit()
            return label
        }()
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(mainImage)
        contentView.addSubview(webtoonTitle)
        contentView.addSubview(author)
        contentView.addSubview(ratingStar)
        contentView.addSubview(ratingScore)
        
        let authorTrailingConstraint = author.trailingAnchor.constraint(equalTo: ratingStar.leadingAnchor)
        author.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            webtoonTitle.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            webtoonTitle.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
            webtoonTitle.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor),

            author.leadingAnchor.constraint(equalTo: webtoonTitle.leadingAnchor),
            author.topAnchor.constraint(equalTo: webtoonTitle.bottomAnchor, constant: 2),
            authorTrailingConstraint,

            ratingStar.trailingAnchor.constraint(equalTo: ratingScore.leadingAnchor, constant: -2),
            ratingStar.widthAnchor.constraint(equalToConstant: 10),
            ratingStar.heightAnchor.constraint(equalToConstant: 10),
            ratingStar.centerYAnchor.constraint(equalTo: author.centerYAnchor),

            ratingScore.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            ratingScore.centerYAnchor.constraint(equalTo: ratingStar.centerYAnchor)
        ])
    }
    
    func configureCell(viewModel: WebtoonHome.WebtoonList.ViewModel) {
        author.text = viewModel.author
        webtoonTitle.text = viewModel.title
        ratingScore.text = "8.56"
    }
}
