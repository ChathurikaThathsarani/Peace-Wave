//
// StressSummaryView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI
import CoreData
import Charts

struct StressSummaryView: View {
    @Environment(\.managedObjectContext) private var viewContext // CoreData context
    
    var body: some View {
        
        // Fetch stress logs for the current month
        let logs = fetchStressLogsForCurrentMonth(context: viewContext)
        let stressLevelsByTrigger = calculateStressLevelsByTrigger(logs: logs)
        let stressData = stressLevelsByTrigger.map { PieChartData(title: $0.key, value: Double($0.value)) }
        
        // Fetch exercise logs for the current month
        let exerciseLogs = fetchExerciseLogsForCurrentMonth(context: viewContext)
        let exerciseDurationByType = calculateExerciseDurationByType(logs: exerciseLogs)
        let exerciseData = exerciseDurationByType.map { PieChartData(title: $0.key, value: Double($0.value)) }
        
        // Get current month
        let monthName = getCurrentMonthName()
        
        GeometryReader { geometry in
            ScrollView (showsIndicators: false){
                VStack {
                    Text("Stress Summary\nfor \(monthName)")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .bold()
                    
                    // Pie chart for stress data
                    PieChartView(data: stressData)
                        .frame(height: geometry.size.height * 0.4)
                        .padding()
                    
                    Text("Exercise Summary\nfor \(monthName)")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .bold()
                    
                    // Pie chart for exercise data
                    PieChartView(data: exerciseData)
                        .frame(height: geometry.size.height * 0.4)
                        .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}


// Function to fetch stress logs for the current month
func fetchStressLogsForCurrentMonth(context: NSManagedObjectContext) -> [StressLog] {
    let request: NSFetchRequest<StressLog> = StressLog.fetchRequest() // Create a fetch request for the StressLog entity
    let calendar = Calendar.current // Get the current calendar
    let now = Date() // Get the current date and time
    let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))! // Calculate the start of the current month
    let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!  // Calculate the end of the current month
    // This ensures that only StressLog objects with a date between startOfMonth and endOfMonth are fetched
    request.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfMonth as NSDate, endOfMonth as NSDate)
    do {
        return try context.fetch(request)  // Return the fetched StressLog objects if successful
    } catch {
        print("Failed to fetch stress logs: \(error)")
        return []
    }
}

// Function to get the current month's name
func getCurrentMonthName() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    let monthName = dateFormatter.string(from: Date())
    return monthName
}


// Function to calculate stress levels by trigger
func calculateStressLevelsByTrigger(logs: [StressLog]) -> [String: Int16] {
    // Empty dictionary to store the stress levels by trigger
    var stressLevelsByTrigger: [String: Int16] = [:]
    // Iterate through each log in the logs array
    for log in logs {
        // Get the trigger from the log, or use "Unknown" if the trigger is nil
        let trigger = log.trigger ?? "Unknown"
        
        // Add the stress level from the log to the total for this trigger
        stressLevelsByTrigger[trigger, default: 0] += log.stressLevel
    }
    return stressLevelsByTrigger
}

// Function to fetch exercise logs for the current month
func fetchExerciseLogsForCurrentMonth(context: NSManagedObjectContext) -> [Exercise] {
    let request: NSFetchRequest<Exercise> = Exercise.fetchRequest() // Create a fetch request for the ExerciseLog
    let calendar = Calendar.current // Get the current calendar
    let now = Date() // Get the current date and time
    let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))! // Calculate the start of the current month
    let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)! // Calculate the end of the current month
    request.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfMonth as NSDate, endOfMonth as NSDate) // This ensures that only ExerciseLog objects with a date between startOfMonth and endOfMonth are fetched
    
    do {
        return try context.fetch(request) // Return the fetched ExerciseLog objects if successful
    } catch {
        print("Failed to fetch exercise logs: \(error)")
        return []
    }
}


// Function to calculate exercise duration by type
func calculateExerciseDurationByType(logs: [Exercise]) -> [String: Int16] {
    // Empty dictionary to store the minutes in ducration by exercise type
    var exerciseDurationByType: [String: Int16] = [:]
    
    for log in logs {
        let type = log.type ?? "Unknown" // Get the exercise type from the log, or use "Unknown" if the trigger is nil
        exerciseDurationByType[type, default: 0] += log.duration   // Add the ducration from the log to the total for this exercise type
    }
    return exerciseDurationByType
}

#Preview {
    StressSummaryView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
}

