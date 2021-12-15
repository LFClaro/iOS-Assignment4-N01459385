//
//  CoreDataService.swift
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import Foundation
import CoreData

class CoreDataService {
    static var shared : CoreDataService = CoreDataService()

    func getAllBoardGames() -> [BoardGame]{
        var result = [BoardGame]()

        // select * from BoardGame order by task
        let fetch = BoardGame.fetchRequest()

        // adding order by date
        fetch.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]

        do{
            result = try persistentContainer.viewContext.fetch(fetch)
        }catch {}

        return result
    }

    func insertNewBoardGame(name: String, id:String){
        let newBoardGame = BoardGame(context: persistentContainer.viewContext)
        newBoardGame.name = name
        newBoardGame.id = id
        saveContext()
    }

    func deleteBoardGame(toDelete : BoardGame){
        persistentContainer.viewContext.delete(toDelete)
        saveContext()
    }

    func getAllBGContaining(str: String) -> [BoardGame]{
        var result = [BoardGame]()
        
        let fetch = BoardGame.fetchRequest()

        if (!str.isEmpty){
            let predicate = NSPredicate(format: "id BEGINSWITH [c] %@", str as CVarArg)
            fetch.predicate = predicate
        }
        do{
            result = try persistentContainer.viewContext.fetch(fetch)
        }catch {}

        return result
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Assignment4_N01459385")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
