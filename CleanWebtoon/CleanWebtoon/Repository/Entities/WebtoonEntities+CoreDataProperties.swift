//
//  WebtoonEntities+CoreDataProperties.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/06.
//
//

import Foundation
import CoreData


extension WebtoonEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WebtoonEntities> {
        return NSFetchRequest<WebtoonEntities>(entityName: "WebtoonEntities")
    }

    @NSManaged public var webtoonEntities: [WebtoonEntity]
    
}

extension WebtoonEntities : Identifiable {

}
