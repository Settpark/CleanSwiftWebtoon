//
//  WebtoonListCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import UIKit

protocol DetailListRoutingListener: AnyObject {
    func routeToDetailWebtoonList(webtoonTitle: String)
}

class WebtoonListCell: UICollectionViewCell {
    
    weak var routingListener: DetailListRoutingListener?
    
    private var imageLoadingTask: URLSessionDataTask?
    static var identifier = "webtoonListCell"
    
    private let mainImage: UIImageView
    private let webtoonTitle: UILabel
    private let author: UILabel
    private let ratingStar: UIImageView
    private let ratingScore: UILabel
    
    private var imageURL: String
    private var cacheKey: String
    private var routingTarget: String
    
    override init(frame: CGRect) {
        mainImage = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 5
            return imageView
        }()
        webtoonTitle = {
            let label = UILabel()
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12, weight: .semibold)
            label.sizeToFit()
            return label
        }()
        author = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemGray3
            label.font = .systemFont(ofSize: 9)
            return label
        }()
        ratingStar = {
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = .systemGray3
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        ratingScore = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemGray3
            label.font = .systemFont(ofSize: 9)
            label.sizeToFit()
            return label
        }()
        imageURL = ""
        cacheKey = ""
        routingTarget = ""
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
        self.mainImage.image = nil
        self.author.text = nil
        self.webtoonTitle.text = nil
        self.ratingScore.text = nil
        
        self.imageURL = ""
        self.cacheKey = ""
        self.routingTarget = ""
    }
    
    private func setupViews() {
        contentView.addSubview(mainImage)
        contentView.addSubview(webtoonTitle)
        contentView.addSubview(author)
        contentView.addSubview(ratingStar)
        contentView.addSubview(ratingScore)
        
        let authorTrailingConstraint = author.trailingAnchor.constraint(equalTo: ratingStar.leadingAnchor, constant: -3)
        author.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            webtoonTitle.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            webtoonTitle.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 5),
            webtoonTitle.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor),

            author.leadingAnchor.constraint(equalTo: webtoonTitle.leadingAnchor),
            author.topAnchor.constraint(equalTo: webtoonTitle.bottomAnchor, constant: 2),
            author.heightAnchor.constraint(equalToConstant: 11),
            authorTrailingConstraint,

            ratingStar.trailingAnchor.constraint(equalTo: ratingScore.leadingAnchor, constant: -2),
            ratingStar.topAnchor.constraint(equalTo: author.topAnchor, constant: 2),
            ratingStar.bottomAnchor.constraint(equalTo: author.bottomAnchor, constant: -2),
            ratingStar.widthAnchor.constraint(equalTo: ratingStar.heightAnchor, multiplier: 1),

            ratingScore.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            ratingScore.centerYAnchor.constraint(equalTo: ratingStar.centerYAnchor)
        ])
    }
    
    func configureCell(viewModel: WebtoonHomeWebtoonList.WebtoonModels.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.author.text = viewModel.author
            self?.webtoonTitle.text = viewModel.title
            self?.ratingScore.text = "8.56"
        }
        imageURL = viewModel.img
        cacheKey = viewModel.title
        routingTarget = viewModel.title
    }
    
    func loadImage() {
        imageLoadingTask = UIImage.loadImage(from: self.imageURL) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.mainImage.image = image
                ImageCacheManger.shared.cacheImage(forKey: self.cacheKey, image: image)
            }
        }
        if let validCacheImage = ImageCacheManger.shared.loadCachedImage(forKey: self.cacheKey) {
            DispatchQueue.main.async { [weak self] in
                self?.mainImage.image = validCacheImage
            }
            return
        }
        guard let imageLoadingTask = imageLoadingTask else {
            return
        }
        imageLoadingTask.resume()
    }
    
    func routeToDetailListView() {
        routingListener?.routeToDetailWebtoonList(webtoonTitle: routingTarget)
    }
}
