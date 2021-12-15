//
//  BoardGame+CoreDataProperties.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-14.
//
//

import Foundation
import CoreData


extension BoardGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoardGame> {
        return NSFetchRequest<BoardGame>(entityName: "BoardGame")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var inCollection: User?

}

extension BoardGame : Identifiable {

}
