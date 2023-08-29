//
//  File.swift
//  
//
//  Created by temp_name on 2023/08/29.
//

import Foundation

public enum UpdateDay: String, CaseIterable {
    case everyDayPlus = "naverDaily"
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    case finished
    
    public func toString() -> String {
        switch self {
        case .everyDayPlus:
            return "매일+"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fri:
            return "금"
        case .sat:
            return "토"
        case .sun:
            return "일"
        case .finished:
            return "완료"
        }
    }
}
