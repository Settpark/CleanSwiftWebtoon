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

    func fetchData<T: NSManagedObject>(type: T.Type, predicate: UpdateDay?) -> [WebtoonEntity] {
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            return []
        }
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            guard let results = results as? [WebtoonEntity] else {
                return []
            }
            if let predicate = predicate {
                let filtered = results.filter {
                    $0.updateDays.contains(predicate.rawValue)
                }
                return filtered
            } else {
                return results
            }
            
        } catch let error as NSError {
            print("Failed to fetch data: \(error), \(error.userInfo)")
        }
        return []
    }
    
    func makeEntity<T: NSManagedObject>(className: String) -> T? {
        let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: className, in: managedObjectContext)
        guard let entity = entity else {
            return nil
        }
        return T(entity: entity, insertInto: managedObjectContext)
    }
    
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
