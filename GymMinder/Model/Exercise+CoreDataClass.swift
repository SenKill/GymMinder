//
//  Exercise+CoreDataClass.swift
//  GymMinder
//
//  Created by Serik Musaev on 25.07.2025.
//
//

import Foundation
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {
    @NSManaged public var breakTime: NSNumber?
    @NSManaged public var equipment: String?
    @NSManaged public var exType: String?
    @NSManaged public var imageName: String?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?
    @NSManaged public var reps: NSNumber?
    @NSManaged public var sets: NSNumber?
    @NSManaged public var weight: NSNumber?
    @NSManaged public var createDate: Date?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }
}

extension Exercise: Identifiable {
    public var id: String {
        return name!
    }
}
