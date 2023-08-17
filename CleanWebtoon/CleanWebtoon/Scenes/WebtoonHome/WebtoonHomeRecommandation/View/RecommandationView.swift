//
//  RecommandationView.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/17.
//

import UIKit

class RecommandationView: UIView {
    private let webtoonImage: UIImageView
    private let webtoonTitle: UILabel
    
    override init(frame: CGRect) {
        webtoonImage = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        webtoonTitle = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 50)
            return label
        }()
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(webtoonImage)
//        self.addSubview(webtoonTitle)
        
        NSLayoutConstraint.activate([
            webtoonImage.topAnchor.constraint(equalTo: self.topAnchor),
            webtoonImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webtoonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webtoonImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
//            webtoonTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
//            webtoonTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
    
    func configureView(imageURL: String,
                       title: String) {
        let task = UIImage.loadImage(from: imageURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                      let image = image else {
                    return
                }
                let resizedImage = UIImage.resizeImage(image: image, newSize: CGSize(width: self.bounds.width, height: self.frame.height))
                self.webtoonImage.image = resizedImage
                self.webtoonTitle.text = title
            }
        }
        task?.resume()
    }
}
