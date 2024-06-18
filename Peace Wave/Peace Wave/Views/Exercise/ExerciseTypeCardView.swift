//
//  ExerciseTypeCardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI

struct ExerciseTypeCardView: View {
    var type: String // The exercise type to display
    
    var body: some View {
        ZStack {
            // Display background image for the exercise type
            if let background = backgroundImage(for: type) {
                Image(background)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 250)
                    .clipped()
                    .shadow(radius: 5)
                    .blur(radius: 10) // Add blur effect
                    .overlay(
                        Color.black.opacity(0.4) // Add semi-transparent overlay to darken the background
                    )
            }
            
            VStack {
                // Display exercise type image
                if let typeImage = image(for: type) {
                    Image(typeImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .clipShape(Circle())
                        .padding(.horizontal)
                }
                // Display exercise type text
                Text("Exercise: \(type)")
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding([.top, .horizontal])
                
                // Display description for the exercise type
                if let description = description(for: type) {
                    Text(description)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .horizontal])
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(width: 350, height: 250)
            .cornerRadius(15)
        }
        .padding(.vertical, 10)
    }
    
    // Helper function to get the background image for the exercise type
    private func backgroundImage(for type: String) -> String? {
        switch type {
        case "Breath":
            return "breath_background"
        case "Meditate":
            return "meditate_background"
        case "Yoga":
            return "yoga_background"
        case "Stretch":
            return "stretch_background"
        case "Walk":
            return "walk_background"
        default:
            return nil
        }
    }
    
    // Helper function to get the exercise type image
    private func image(for type: String) -> String? {
        switch type {
        case "Breath":
            return "breath_image"
        case "Meditate":
            return "meditate_image"
        case "Yoga":
            return "yoga_image"
        case "Stretch":
            return "stretch_image"
        case "Walk":
            return "walk_image"
        default:
            return nil
        }
    }
    
    // Helper function to get the description for the exercise type
    private func description(for type: String) -> String? {
        switch type {
        case "Breath":
            return "Breathing exercises help you relax and reduce stress."
        case "Meditate":
            return "Meditation helps in achieving a mentally clear calm state."
        case "Yoga":
            return "Yoga is a group of physical, mental, and spiritual practices."
        case "Stretch":
            return "Stretching helps improve flexibility and reduce muscle tension."
        case "Walk":
            return "Walking is a great way to improve or maintain your overall health."
        default:
            return nil
        }
    }
}
