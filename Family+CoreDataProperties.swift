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
    @NSManaged public var pets: NSSet?

}

// MARK: Generated accessors for pets
extension Family {

    @objc(addPetsObject:)
    @NSManaged public func addToPets(_ value: Pet)

    @objc(removePetsObject:)
    @NSManaged public func removeFromPets(_ value: Pet)

    @objc(addPets:)
    @NSManaged public func addToPets(_ values: NSSet)

    @objc(removePets:)
    @NSManaged public func removeFromPets(_ values: NSSet)

}

extension Family : Identifiable {

}
