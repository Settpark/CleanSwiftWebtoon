//
//  Date+.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/28.
//

import Foundation

extension Date {
    static func makeTodayWeekday() -> UpdateDay {
        let date = Date()

        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let weekdaySymbols = dateFormatter.weekdaySymbols

        let currentWeekday = weekday - 1
        
        guard let weekdaySymbols = weekdaySymbols else {
            return .everyDayPlus
        }
        
        switch weekdaySymbols[currentWeekday] {
        case "월요일":
            return .mon
        case "화요일":
            return .tue
        case "수요일":
            return .wed
        case "목요일":
            return .thu
        case "금요일":
            return .fri
        case "토요일":
            return .sat
        case "일요일":
            return .sun
        default:
            return .everyDayPlus
        }
    }
}
