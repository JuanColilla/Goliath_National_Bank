//
//  CoreDataStack.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {

    /// Singleton to share a unique instance of this class across all the app code.
    static let sharedInstance = CoreDataStack()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    // Overriding and making the initializer private we avoid anyone to instance again this class.
    private override init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "DataPersistence")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error no resuelto \(error.localizedDescription), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error no resuelto \(nserror.localizedDescription), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchCachedTransactionsData() -> [SKUModel] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SKUModel")
        
        var cachedData = [SKUModel]()
        do {
            cachedData = try context.fetch(request) as! [SKUModel]
        } catch let error {
            print("Error recuperando los Places guardados...\(error.localizedDescription)")
        }
        return cachedData
    }
    
    func fetchCachedRatiosData() -> [ConversionRateModel] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ConversionRateModel")
        
        var cachedData = [ConversionRateModel]()
        do {
            cachedData = try context.fetch(request) as! [ConversionRateModel]
        } catch let error {
            print("Error recuperando los Places guardados...\(error.localizedDescription)")
        }
        return cachedData
    }
    
    
    func deleteAllData() {
        for result in fetchCachedTransactionsData() {
            context.delete(result)
        }
        for result in fetchCachedRatiosData() {
            context.delete(result)
        }
        saveContext()
    }
    
}
