//
//  DetailListCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/22.
//

import UIKit

class DetailListCell: UICollectionViewCell {
    
    //TODO: setRoutingListener
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    
    private let previewImage: UIImageView
    private let title: UILabel
    private let infoStackView: UIStackView
    private let rating: UILabel
    private let updateDate: UILabel
    
    override init(frame: CGRect) {
        previewImage = {
            let imageView = UIImageView(image: UIImage(named: "default_icon"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        title = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12)
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
            label.font = .systemFont(ofSize: 9)
            return label
        }()
        updateDate = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 9)
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
        addSubview(title)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(rating)
        infoStackView.addArrangedSubview(updateDate)
        
        NSLayoutConstraint.activate([
            previewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            previewImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            previewImage.widthAnchor.constraint(equalToConstant: 40),
            previewImage.heightAnchor.constraint(equalToConstant: 30),
            
            title.topAnchor.constraint(equalTo: previewImage.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 10),
            
            infoStackView.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 10),
        ])
    }
    
    func configureView(viewModel: WebtoonDetailList.DetailList.ViewModel) {
        title.text = viewModel.title
        rating.text = viewModel.title
        updateDate.text = viewModel.title
    }
}
