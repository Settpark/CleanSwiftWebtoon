//
//  DetailListCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/22.
//

import UIKit

protocol WebtoonBodyRoutingEventListener: AnyObject {
    func routeToBody(webtoonListIndex: Int)
}

class DetailListCell: UICollectionViewCell {
    
    weak var listener: WebtoonBodyRoutingEventListener?
    
    //TODO: setRoutingListener
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    
    private let previewImage: UIImageView
    private let titleStackView: UIStackView
    private let title: UILabel
    private let infoStackView: UIStackView
    private let rating: UILabel
    private let updateDate: UILabel
    
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
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(previewImage)
        addSubview(titleStackView)
        addSubview(infoStackView)
        titleStackView.addArrangedSubview(title)
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
            infoStackView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImage.image = UIImage(named: "default_icon")
        title.text = ""
        rating.text = ""
        updateDate.text = ""
    }
    
    func configureView(viewModel: WebtoonDetailList.DetailList.ViewModel) {
        title.text = viewModel.title
        rating.text = viewModel.rating
        updateDate.text = viewModel.date
        
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
        listener?.routeToBody(webtoonListIndex: index)
    }
}
