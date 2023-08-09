//
//  WebtoonSecitonCell.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/09.
//

import UIKit

class WebtoonSectionCell: UICollectionViewCell {
    func configureCell(contentView: UIView) {
        self.contentView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            
        ])
    }
}
