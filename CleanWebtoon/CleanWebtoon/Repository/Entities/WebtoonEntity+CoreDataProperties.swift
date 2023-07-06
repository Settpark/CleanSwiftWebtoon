//
//  WebtoonEntity+CoreDataProperties.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/06.
//
//

import Foundation
import CoreData


extension WebtoonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WebtoonEntity> {
        return NSFetchRequest<WebtoonEntity>(entityName: "WebtoonEntity")
    }

    @NSManaged public var author: String
    @NSManaged public var img: String
    @NSManaged public var title: String
}

extension WebtoonEntity : Identifiable {
    func save(value: WebtoonHome.Webtoon) {
        self.title = value.title
        self.author = value.author
        self.img = value.img
        
        do {
            try managedObjectContext?.save()
            print("Data added successfully")
        } catch let error as NSError {
            print("Failed to save data: \(error), \(error.userInfo)")
        }
    }
}
