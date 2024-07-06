//
//  Family+CoreDataProperties.swift
//  doggie
//
//  Created by Maggie Gong on 7/5/24.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }

    @NSManaged public var birthDate: Date?
    @NSManaged public var joinedDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var petToMeal: NSSet?

}

// MARK: Generated accessors for petToMeal
extension Family {

    @objc(addPetToMealObject:)
    @NSManaged public func addToPetToMeal(_ value: Meal)

    @objc(removePetToMealObject:)
    @NSManaged public func removeFromPetToMeal(_ value: Meal)

    @objc(addPetToMeal:)
    @NSManaged public func addToPetToMeal(_ values: NSSet)

    @objc(removePetToMeal:)
    @NSManaged public func removeFromPetToMeal(_ values: NSSet)

}

extension Family : Identifiable {

}
