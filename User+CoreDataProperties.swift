//
//  User+CoreDataProperties.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-14.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var allGames: NSSet?

}

// MARK: Generated accessors for allGames
extension User {

    @objc(addAllGamesObject:)
    @NSManaged public func addToAllGames(_ value: BoardGame)

    @objc(removeAllGamesObject:)
    @NSManaged public func removeFromAllGames(_ value: BoardGame)

    @objc(addAllGames:)
    @NSManaged public func addToAllGames(_ values: NSSet)

    @objc(removeAllGames:)
    @NSManaged public func removeFromAllGames(_ values: NSSet)

}

extension User : Identifiable {

}
