//
//  WeekDayView.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/18.
//

import UIKit

class WeekDayView: UIView {
    private let weekDayLabel: UILabel
    
    init(day: WebtoonHomeWebtoonList.UpdateDay) {
        weekDayLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .semibold)
            label.text = day.toString()
            return label
        }()
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(weekDayLabel)
        
        NSLayoutConstraint.activate([
            weekDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weekDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
