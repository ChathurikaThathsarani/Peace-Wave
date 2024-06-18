//
//  StressLogListView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI
import CoreData

struct StressLogListView: View {
    
    // CoreData context environment variable
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch request for StressLog entities sorted by date in descending order
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StressLog.date, ascending: false)], // Sort by date descending
        animation: .default) // Default animation
    private var stressLogs: FetchedResults<StressLog>
    
    var body: some View {
        NavigationView {
            List {
                // Iterate over fetched stress logs
                ForEach(stressLogs) { log in
                    // Navigation link to detail view for each log
                    NavigationLink(destination: StressLogDetailView(log: log)) {
                        StressLogCardView(log: log)
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
            .navigationBarTitle("Stress Logs")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // Toolbar item for adding a new log
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: StressLogFormView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    // Function to delete a log
    private func deleteLog(_ log: StressLog) {
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
    StressLogListView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
}

