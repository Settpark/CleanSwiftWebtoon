//
//  Font+.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/30.
//

import UIKit

extension UIFont {
    static func makeCrisisKRFont(size: CGFloat) -> UIFont {
        return UIFont(name: "ClimateCrisisKR-1979", size: size) ?? .systemFont(ofSize: size)
    }
}
