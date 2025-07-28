//
//  CoreDataStack.swift
//  GymMinder
//
//  Created by Serik Musaev on 20.07.2025.
//

import CoreData

final class CoreDataStack: NSObject {
    static let shared = CoreDataStack()
    let container = NSPersistentContainer(name: "GymModel")
    
    override init() {
        super.init()
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchPrograms() {
        
    }
    
    func getExercises() -> [Exercise] {
        let exerciseFR: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let createDateSD = NSSortDescriptor(key: "createDate", ascending: true)
        exerciseFR.sortDescriptors = [createDateSD]
        let exercisesFRC = NSFetchedResultsController(
            fetchRequest: exerciseFR,
            managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil)
        try? exercisesFRC.performFetch()
        if let fetchedExes = exercisesFRC.fetchedObjects {
            return fetchedExes
        }
        return []
    }
    
    func preloadDefaultData() {
        let pushUps = Exercise(context: context)
        pushUps.name = "Push-ups"
        pushUps.imageName = "testAnimation"
        pushUps.equipment = Equipment.none.rawValue
        pushUps.exType = ExType.bodyweight.rawValue
        pushUps.sets = 4
        pushUps.reps = 10
        pushUps.weight = nil
        pushUps.breakTime = 60
        pushUps.instructions = """
         Place your hands shoulder-width apart on the floor. \n
         Extend your legs straight behind you, with your toes touching the ground. \n
         Keep your body in a straight line from head to heels. Engage your core and glutes. \n
         Slowly lower your body by bending your elbows until your chest is just above the floor. \n
         Press through your palms to push your body back up to the starting position. \n
         Repeat for the required reps.
         """
        pushUps.createDate = Date()
        let squats = Exercise(context: context)
        squats.name = "Squats"
        squats.imageName = "testAnimation"
        squats.equipment = Equipment.none.rawValue
        squats.exType = ExType.bodyweight.rawValue
        squats.sets = 4
        squats.reps = 10
        squats.weight = 50
        squats.breakTime = 90
        squats.instructions = "JUST DO IT"
        squats.createDate = Date()
        let deadlifts = Exercise(context: context)
        deadlifts.name = "Deadlifts"
        deadlifts.imageName = "testAnimation"
        deadlifts.equipment = Equipment.none.rawValue
        deadlifts.exType = ExType.bodyweight.rawValue
        deadlifts.sets = 3
        deadlifts.reps = 8
        deadlifts.weight = 80
        deadlifts.breakTime = 120
        deadlifts.instructions = "JUST DO IT"
        deadlifts.createDate = Date()
        let bicepCurls = Exercise(context: context)
        bicepCurls.name = "Bicep Curls"
        bicepCurls.imageName = "testAnimation"
        bicepCurls.equipment = Equipment.none.rawValue
        bicepCurls.exType = ExType.bodyweight.rawValue
        bicepCurls.sets = 3
        bicepCurls.reps = 15
        bicepCurls.weight = 10
        bicepCurls.breakTime = 45
        bicepCurls.instructions = "JUST DO IT"
        bicepCurls.createDate = Date()
        saveContext()
    }
}
