//
//  Meal+CoreDataProperties.swift
//  doggie
//
//  Created by Maggie Gong on 7/6/24.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var amount: String?
    @NSManaged public var meal: String?
    @NSManaged public var time: String?
    @NSManaged public var date: Date?
    @NSManaged public var mealToPet: Family?

}

extension Meal : Identifiable {

}
