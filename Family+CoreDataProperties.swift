//
//  Family+CoreDataProperties.swift
//  doggie
//
//  Created by Maggie Gong on 7/6/24.
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
    @NSManaged public var petToActivity: NSSet?

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

// MARK: Generated accessors for petToActivity
extension Family {

    @objc(addPetToActivityObject:)
    @NSManaged public func addToPetToActivity(_ value: Activity)

    @objc(removePetToActivityObject:)
    @NSManaged public func removeFromPetToActivity(_ value: Activity)

    @objc(addPetToActivity:)
    @NSManaged public func addToPetToActivity(_ values: NSSet)

    @objc(removePetToActivity:)
    @NSManaged public func removeFromPetToActivity(_ values: NSSet)

}

extension Family : Identifiable {

}
