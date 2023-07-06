//
//  CoreDataManager.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/06.
//

import Foundation
import CoreData

class CoreDataManager {
    private var persistentContainer: NSPersistentContainer
    private var managedObjectContext: NSManagedObjectContext
    
    init(persistentContainerName: String) {
        self.persistentContainer = {
            let container = NSPersistentContainer(name: persistentContainerName)
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
        }()
        self.managedObjectContext = self.persistentContainer.viewContext
    }

    func fetchData<T: NSManagedObject>(type: T.Type) {
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            return
        }
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if let results = results as? [WebtoonEntity] {
                results.forEach { print($0.title) }
            }
        } catch let error as NSError {
            print("Failed to fetch data: \(error), \(error.userInfo)")
        }
    }
    
    func makeEntity<T: NSManagedObject>(className: String) -> T? {
        let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: className, in: managedObjectContext)
        guard let entity = entity else {
            return nil
        }
        return T(entity: entity, insertInto: managedObjectContext)
    }
    
    // Core Data에서 데이터 삭제하기
    func deleteData<T: NSManagedObject>(type: T.Type,
                                        targetTitle: String) {
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            return
        }
        fetchRequest.predicate = NSPredicate(format: "title == %@", targetTitle)

        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            for data in results {
                managedObjectContext.delete(data)
            }
            try managedObjectContext.save()
            print("Data deleted successfully")
        } catch let error as NSError {
            print("Failed to delete data: \(error), \(error.userInfo)")
        }
    }
}
