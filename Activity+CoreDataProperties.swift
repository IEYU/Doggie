//
//  Activity+CoreDataProperties.swift
//  doggie
//
//  Created by Maggie Gong on 7/6/24.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var activityName: String?
    @NSManaged public var activityTime: String?
    @NSManaged public var date: Date?
    @NSManaged public var activityToPet: Family?

}

extension Activity : Identifiable {

}
