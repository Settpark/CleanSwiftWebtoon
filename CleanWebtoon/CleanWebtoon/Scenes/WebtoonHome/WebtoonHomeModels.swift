import UIKit

protocol WebtoonCollectionType {
    
}

enum WebtoonHomeModels {
    enum WebtoonHomeTabSection: Int {
        case recommand
        case week
        case webtoonList
    }
    struct LastUpdateModel: Decodable {
        var lastUpdate: String
    }
    enum WeekModel: WebtoonCollectionType {
        case new
        case everyDayPlus
        case mon
        case tue
        case wed
        case tur
        case fri
        case sat
        case sun
        case complete
    }
    enum WebtoonModel {
        struct Request {
            var page: Int
            var perPage: Int
            var service: String
            var updateDay: UpdateDay
            
            static var empty = Self.init()
            
            init(page: Int, perPage: Int, service: String, updateDay: UpdateDay) {
                self.page = page
                self.perPage = perPage
                self.service = service
                self.updateDay = updateDay
            }
            
            init() {
                page = 0
                perPage = 0
                service = ""
                updateDay = .everyDayPlus
            }
        }
        struct Response: Decodable {
            var title: String
            var author: String
            var url: String
            var img: String
            var service: String
            var updateDays: [String]
            var additional: ResponseAdditional
            
            static var empty = Self.init()
            
            init() {
                self.title = ""
                self.author = ""
                self.url = ""
                self.img = ""
                self.service = ""
                self.updateDays = []
                self.additional = ResponseAdditional.empty
            }
        }
        struct ResponseAdditional: Decodable {
            var new: Bool
            var adult: Bool
            var rest: Bool
            var up: Bool
            
            static var empty = Self.init()
            
            init() {
                new = false
                adult = false
                rest = false
                up = false
            }
        }
        struct ViewModel: Hashable, WebtoonCollectionType {
            var title: String
            var author: String
            var img: String
            var isNew: Bool
            var isAdult: Bool
            var isRest: Bool
            var isUp: Bool
            var isOver15: Bool
            var isFree: Bool
            var isWaitFree: Bool
            
            init(title: String, author: String, img: String, isNew: Bool, isAdult: Bool,
                 isRest: Bool, isUp: Bool, isOver15: Bool, isFree: Bool, isWaitFree: Bool) {
                self.title = title
                self.author = author
                self.img = img
                self.isNew = isNew
                self.isAdult = isAdult
                self.isRest = isRest
                self.isUp = isUp
                self.isOver15 = isOver15
                self.isFree = isFree
                self.isWaitFree = isWaitFree
            }
        }
    }
}
