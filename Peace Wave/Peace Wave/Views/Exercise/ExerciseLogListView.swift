//
//  ExerciseLogListView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI
import CoreData

struct ExerciseLogListView: View {
    @Environment(\.managedObjectContext) private var viewContext // CoreData context environment variable
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.date, ascending: false)], // Fetch request sorted by date in descending order
        animation: .default) // Default animation for fetch request
    private var exerciseLogs: FetchedResults<Exercise> // Fetched results for Exercise entities
    
    var body: some View {
        NavigationView {
            List {
                // Iterate over fetched exercise logs
                ForEach(exerciseLogs) { log in
                    NavigationLink(destination: ExerciseLogDetailView(log: log)) {
                        ExerciseLogCardView(log: log) // Custom view for displaying log details
                    }
                    // Swipe action to delete a log
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteLog(log)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Exercise Logs")
            .toolbar {
                // Toolbar item for adding a new log
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ExerciseLogFormView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    // Function to delete a log
    private func deleteLog(_ log: Exercise) {
        withAnimation {
            viewContext.delete(log) // Delete the log from the context
            do {
                try viewContext.save() // Save the context
                print("Deleted log: \(log)")
            } catch {
                print("Error deleting log: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ExerciseLogListView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
}

