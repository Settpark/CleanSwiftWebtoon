//
//  CAGradientLayer+.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/30.
//

import UIKit

extension CAGradientLayer {
    static func makeGreenGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = .zero
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }
}
