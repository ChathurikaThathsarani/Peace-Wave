//
//  ExerciseSummaryTests.swift
//  Peace WaveTests
//
//  Created by Chathurika Dombepola on 2024-06-10.
//

import XCTest
import CoreData
@testable import Peace_Wave

final class ExerciseSummaryTests: XCTestCase {

    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        // Initialize in-memory Core Data stack
        let persistentContainer = NSPersistentContainer(name: "Model")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (description, error) in
            XCTAssertNil(error)
        }
        managedObjectContext = persistentContainer.viewContext
    }
    
    override func tearDown() {
        managedObjectContext = nil
        super.tearDown()
    }
    
    func testCalculateExerciseDurationByType() {
            // Given
            let exercise1 = Exercise(context: managedObjectContext)
            exercise1.type = "Walk"
            exercise1.duration = 30
            
            let exercise2 = Exercise(context: managedObjectContext)
            exercise2.type = "Yoga"
            exercise2.duration = 20
            
            let exercise3 = Exercise(context: managedObjectContext)
            exercise3.type = "Walk"
            exercise3.duration = 45
            
            let exerciseLogs = [exercise1, exercise2, exercise3]

            // When
            let result = calculateExerciseDurationByType(logs: exerciseLogs)

            // Then
            XCTAssertEqual(result["Walk"], 75)
            XCTAssertEqual(result["Yoga"], 20)
        }
}
