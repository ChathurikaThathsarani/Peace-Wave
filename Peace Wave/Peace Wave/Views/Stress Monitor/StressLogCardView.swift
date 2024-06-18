//
//  StressLogCardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI

struct StressLogCardView: View {
    var log: StressLog // StressLog object to display
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon(for: log.trigger ?? "Other"))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(color(for: log.trigger ?? "Other"))
                VStack(alignment: .leading) {
                    Text("Date: \(log.date ?? Date(), formatter: dateFormatter)")
                        .font(.headline)
                    Text("Stress Level: \(log.stressLevel)")
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
    
    // Function to return an icon name based on the trigger
    private func icon(for trigger: String) -> String {
        switch trigger {
        case "Work":
            return "briefcase.fill"
        case "Family":
            return "house.fill"
        case "Health":
            return "heart.fill"
        case "Finances":
            return "dollarsign.circle.fill"
        default:
            return "questionmark.circle.fill"
        }
    }
    
    // Function to return a color based on the trigger
    private func color(for trigger: String) -> Color {
        switch trigger {
        case "Work":
            return .blue
        case "Family":
            return .green
        case "Health":
            return .red
        case "Finances":
            return .yellow
        default:
            return .black
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
