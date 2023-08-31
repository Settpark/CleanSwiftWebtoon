//
//  DetailListCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/22.
//

import UIKit
import CustomUtility

protocol WebtoonBodyRoutingEventListener: AnyObject {
    func routeToBody(webtoonListIndex: Int)
}

class DetailListCell: UICollectionViewCell {
    
    weak var routingEventlistener: WebtoonBodyRoutingEventListener?
    
    //TODO: setRoutingListener
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    private var imageLoadingTask: URLSessionDataTask?
    
    private let previewImage: UIImageView
    private let titleStackView: UIStackView
    private let title: UILabel
    private let infoStackView: UIStackView
    private let rating: UILabel
    private let updateDate: UILabel
    private var imageURL: String
    private var cacheKey: String
    
    override init(frame: CGRect) {
        previewImage = {
            let imageView = UIImageView(image: UIImage(named: "default_icon"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 7
            return imageView
        }()
        titleStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.distribution = .equalSpacing
            return stackView
        }()
        title = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        infoStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 3
            stackView.distribution = .equalSpacing
            return stackView
        }()
        rating = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 10)
            return label
        }()
        updateDate = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 10)
            return label
        }()
        imageURL = ""
        cacheKey = ""
        super.init(frame: frame)
        setupViews()
    }
    
    deinit {
        imageLoadingTask = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(previewImage)
        addSubview(titleStackView)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(rating)
        infoStackView.addArrangedSubview(updateDate)
        
        NSLayoutConstraint.activate([
            previewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            previewImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            previewImage.widthAnchor.constraint(equalToConstant: 90),
            previewImage.heightAnchor.constraint(equalToConstant: 60),
            
            titleStackView.bottomAnchor.constraint(equalTo: previewImage.centerYAnchor, constant: -2.5),
            titleStackView.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 10),
            
            infoStackView.topAnchor.constraint(equalTo: previewImage.centerYAnchor, constant: 2.5),
            infoStackView.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 10) ,
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImage.image = UIImage(named: "default_icon")
        title.text = ""
        rating.text = ""
        updateDate.text = ""
        cacheKey = ""
        imageURL = ""
        titleStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configureView(viewModel: WebtoonDetailList.DetailList.ViewModel) {
        previewImage.image = UIImage(named: "default_icon")
        title.text = viewModel.title
        rating.text = viewModel.rating
        updateDate.text = viewModel.date
        imageURL = viewModel.img
        cacheKey = viewModel.cacheKey
        
        titleStackView.addArrangedSubview(title)
        if let subTitle = viewModel.subTitle {
            let subTitle: UILabel = {
                let label = UILabel()
                label.text = subTitle
                label.font = .systemFont(ofSize: 14)
                return label
            }()
            titleStackView.addArrangedSubview(subTitle)
        }
    }
    
    func routeToBody(index: Int) {
        routingEventlistener?.routeToBody(webtoonListIndex: index)
    }
    
    func loadImage() {
        imageLoadingTask = UIImage.loadImage(from: self.imageURL) { [weak self] image in
            guard let self = self, let image = image else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.previewImage.image = image
                ImageCacheManger.shared.cacheImage(forKey: self.cacheKey, image: image)
            }
            self.imageLoadingTask = nil
        }
        if let validCacheImage = ImageCacheManger.shared.loadCachedImage(forKey: self.cacheKey) {
            DispatchQueue.main.async { [weak self] in
                self?.previewImage.image = validCacheImage
            }
            return
        }
        guard let imageLoadingTask = imageLoadingTask else {
            return
        }
        imageLoadingTask.resume()
    }
}
