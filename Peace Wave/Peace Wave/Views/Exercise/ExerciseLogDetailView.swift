//
//  ExerciseLogDetailView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct ExerciseLogDetailView: View {
    var log: Exercise // The Exercise object to display details
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ExerciseTypeCardView(type: log.type ?? "Unknown") // Display exercise type card view
            
            ScrollView(showsIndicators: false) {
                // Detail cards for various attributes of the exercise log
                DetailCard(icon: "clock.fill", title: "Duration", value: "\(log.duration) minutes", color: .blue)
                DetailCard(icon: "speedometer", title: "Intensity", value: log.intensity ?? "Unknown", color: .orange)
                DetailCard(icon: "calendar", title: "Date", value: formattedDate(log.date ?? Date()), color: .green)
                DetailCard(icon: "note.text", title: "Notes", value: log.notes ?? "None", color: .black)
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}



#Preview {
    let context = Persistence.preview.container.viewContext
    let newExercise = Exercise(context: context)
    newExercise.id = UUID()
    newExercise.type = "Breath"
    newExercise.duration = 15
    newExercise.intensity = "Low"
    newExercise.date = Date()
    newExercise.notes = "Sample exercise notes"
    
    return ExerciseLogDetailView(log: newExercise)
}

