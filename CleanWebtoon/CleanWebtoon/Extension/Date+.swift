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
    
    static func isAlreadyFetch(serverDate: String, targetDate: UpdateDay) -> Bool {
        let inputDateFormatter: DateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy.MM.dd-hh:mm"
        inputDateFormatter.locale = Locale(identifier: "ko_KR")
        let lastUpdateDate = inputDateFormatter.date(from: serverDate)
        
        let deviceLastUpdate = UserDefaults.standard.string(forKey: targetDate.rawValue)
        
        guard let lastUpdateDate = lastUpdateDate,
              let deviceLastUpdateValue = deviceLastUpdate,
              let deviceLastUpdateDate = inputDateFormatter.date(from: deviceLastUpdateValue) else {
            UserDefaults.standard.setValue(serverDate, forKey: targetDate.rawValue)
            return false
        }
        if deviceLastUpdateDate.timeIntervalSince(lastUpdateDate) > 0 {
            return true
        } else {
            return false
        }
    }
    
    static func makeTodayToString() -> String {
        let inputDateFormatter: DateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy.MM.dd-hh:mm"
        inputDateFormatter.locale = Locale(identifier: "ko_KR")
        let lastUpdateDate = inputDateFormatter.string(from: Date())
        return lastUpdateDate
    }
    
    static func makeUpdateDayToInt(_ updateDay: UpdateDay) -> Int {
        switch updateDay {
        case .new:
            return 2
        case .everyDayPlus:
            return 1
        case .mon:
            return 3
        case .tue:
            return 4
        case .wed:
            return 5
        case .thu:
            return 6
        case .fri:
            return 7
        case .sat:
            return 8
        case .sun:
            return 9
        case .finished:
            return 10
        }
    }
}
