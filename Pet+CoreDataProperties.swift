//
//  Pet+CoreDataProperties.swift
//  doggie
//
//  Created by Maggie Gong on 7/5/24.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String?
    @NSManaged public var meal: String?
    @NSManaged public var time: String?
    @NSManaged public var amount: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var joinedDate: Date?
    @NSManaged public var family: Family?

}

extension Pet : Identifiable {

}
