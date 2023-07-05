//
//  EndPoint.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

enum WebtoonSupplier: String {
    case naver
    case kakao
    case kakaoPage
}

enum UpdateDay: String {
    case new
    case everyDayPlus = "naverDaily"
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    case finished
    
    static func makeIntToUpdateDay(value: Int) -> UpdateDay {
        switch value {
        case 0:
            return .new
        case 1:
            return .everyDayPlus
        case 2:
            return .mon
        case 3:
            return .tue
        case 4:
            return .wed
        case 5:
            return .thu
        case 6:
            return .fri
        case 7:
            return .sat
        case 8:
            return .sun
        case 9:
            return .finished
        default:
            return Date.makeTodayWeekday()
        }
    }
    
    static func makeUpdatedayToInt(updateDay: UpdateDay?) -> CGFloat {
        guard let updateDay = updateDay else {
            return -1
        }
        switch updateDay {
        case .new:
            return 0
        case .everyDayPlus:
            return 1
        case .mon:
            return 2
        case .tue:
            return 3
        case .wed:
            return 4
        case .thu:
            return 5
        case .fri:
            return 6
        case .sat:
            return 7
        case .sun:
            return 8
        case .finished:
            return 9
        }
    }
}

struct EndPoint {
    private let baseURL: String
    
    init() {
        self.baseURL = "https://korea-webtoon-api.herokuapp.com/"
    }
    
    func makeEndpoint(page: Int,
                      perPage: Int,
                      service: WebtoonSupplier,
                      updateDay: UpdateDay) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "page", value: String(describing: page)),
                                        URLQueryItem(name: "perPage", value: String(describing: perPage)),
                                        URLQueryItem(name: "service", value: String(describing: service)),
                                        URLQueryItem(name: "updateDay", value: String(describing: updateDay))]
        return endPointComponent
    }
    
    func makeEndpoint(service: WebtoonSupplier) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: service))]
        return endPointComponent
    }
    
    func makeEndpoint(service: WebtoonSupplier,
                      updateDay: UpdateDay) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: service)),
                                        URLQueryItem(name: "updateDay", value: String(describing: updateDay.rawValue)),
                                        URLQueryItem(name: "perPage", value: String(describing: Int16.max))]
        return endPointComponent
    }
}
