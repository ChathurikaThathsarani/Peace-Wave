//
//  ExerciseLogCardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI

struct ExerciseLogCardView: View {
    var log: Exercise // Exercise object to display
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon(for: log.type ?? "Other"))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(color(for: log.type ?? "Other"))
                VStack(alignment: .leading) {
                    Text("Type: \(log.type ?? "Unknown")")
                        .font(.headline)
                    Text("Duration: \(log.duration) minutes")
                        .font(.subheadline)
                    Text("Intensity: \(log.intensity ?? "Unknown")")
                        .font(.subheadline)
                    Text("Date: \(log.date ?? Date(), formatter: dateFormatter)")
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding(.vertical, 5)
    }
    
    // Function to return an icon name based on the exercise type
    private func icon(for type: String) -> String {
        switch type {
        case "Breath":
            return "lungs.fill"
        case "Meditate":
            return "person.fill"
        case "Yoga":
            return "figure.walk"
        case "Stretch":
            return "figure.wave"
        case "Walk":
            return "figure.walk.circle.fill"
        default:
            return "questionmark.circle.fill"
        }
    }
    
    // Function to return a color based on the exercise type
    private func color(for type: String) -> Color {
        switch type {
        case "Breath":
            return .blue
        case "Meditate":
            return .purple
        case "Yoga":
            return .green
        case "Stretch":
            return .orange
        case "Walk":
            return .pink
        default:
            return .gray
        }
    }
}

// Date formatter for displaying log dates
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

