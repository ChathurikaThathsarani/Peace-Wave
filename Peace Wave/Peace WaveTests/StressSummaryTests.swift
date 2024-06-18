//
//  StressSummaryTests.swift
//  Peace WaveTests
//
//  Created by Chathurika Dombepola on 2024-06-10.
//

import XCTest
import CoreData
@testable import Peace_Wave


final class StressSummaryTests: XCTestCase {
    
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
    
    // to clean up and release any resources that were set up for the test
    override func tearDown() {
        managedObjectContext = nil
        super.tearDown()
    }
    
    func testCalculateStressLevelsByTrigger() {
        // Given
        let stressLog1 = StressLog(context: managedObjectContext)
        stressLog1.trigger = "Work"
        stressLog1.stressLevel = 5
        
        let stressLog2 = StressLog(context: managedObjectContext)
        stressLog2.trigger = "Family"
        stressLog2.stressLevel = 3
        
        let stressLog3 = StressLog(context: managedObjectContext)
        stressLog3.trigger = "Work"
        stressLog3.stressLevel = 7
        
        let stressLogs = [stressLog1, stressLog2, stressLog3]
        
        // When
        let result = calculateStressLevelsByTrigger(logs: stressLogs)
        
        // Then
        XCTAssertEqual(result["Work"], 12)
        XCTAssertEqual(result["Family"], 3)
    }
    
}
