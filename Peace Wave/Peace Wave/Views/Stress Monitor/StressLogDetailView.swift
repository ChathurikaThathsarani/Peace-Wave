//
//  StressLogDetailView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct StressLogDetailView: View {
    var log: StressLog // The StressLog object to display details for
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            MoodCardView(mood: log.mood ?? "in a mood") // Display mood card view
            
            ScrollView(showsIndicators: false) {
                // Detail cards for various attributes of the stress log
                DetailCard(icon: "thermometer", title: "Stress Level", value: "\(log.stressLevel)", color: .red)
                DetailCard(icon: "calendar", title: "Date", value: formattedDate(log.date ?? Date()), color: .blue)
                DetailCard(icon: "exclamationmark.triangle.fill", title: "Trigger", value: log.trigger ?? "Unknown", color: .orange)
                DetailCard(icon: "bed.double.fill", title: "Sleep Quality", value: "\(log.sleepQuality) hours", color: .purple)
                DetailCard(icon: "figure.walk", title: "Physical Activity", value: log.physicalActivity ?? "None", color: .green)
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
    let newLog = StressLog(context: context)
    newLog.id = UUID()
    newLog.date = Date()
    newLog.stressLevel = 5
    newLog.trigger = "Work"
    newLog.mood = "Happy"
    newLog.sleepQuality = 8
    newLog.physicalActivity = "Jogging"
    newLog.notes = "Feeling better after exercise."
    
    return StressLogDetailView(log: newLog)
}

