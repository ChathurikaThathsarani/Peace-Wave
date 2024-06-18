//
//  MoodCardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI

struct MoodCardView: View {
    var mood: String // The mood to display
    
    var body: some View {
        ZStack {
            // Display background image for the mood
            if let background = backgroundImage(for: mood) {
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
                // Display mood image
                if let moodImage = image(for: mood) {
                    Image(moodImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .clipShape(Circle())
                        .padding(.horizontal)
                }
                // Display mood text
                Text("You were \(mood)")
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding([.top, .horizontal])
                
                // Display quote for the mood
                if let quote = quote(for: mood) {
                    Text(quote)
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
            .shadow(radius: 5)
        }
        .padding(.vertical, 10)
    }
    
    // Helper function to get the background image for the mood
    private func backgroundImage(for mood: String) -> String? {
        switch mood {
        case "Happy":
            return "happy_background"
        case "Sad":
            return "sad_background"
        case "Anxious":
            return "anxious_background"
        case "Calm":
            return "calm_background"
        case "Angry":
            return "angry_background"
        default:
            return nil
        }
    }
    
    // Helper function to get the mood image
    private func image(for mood: String) -> String? {
        switch mood {
        case "Happy":
            return "happy"
        case "Sad":
            return "sad"
        case "Anxious":
            return "anxious"
        case "Calm":
            return "calm"
        case "Angry":
            return "angry"
        default:
            return nil
        }
    }
    
    // Helper function to get the quote for the mood
    private func quote(for mood: String) -> String? {
        switch mood {
        case "Happy":
            return "Happiness is not by chance, but by choice."
        case "Sad":
            return "Every day may not be good, but there is something good in every day."
        case "Anxious":
            return "Don’t control your thoughts. Just stop letting them control you."
        case "Calm":
            return "Calmness is the cradle of power."
        case "Angry":
            return "Anger is one letter short of danger."
        default:
            return nil
        }
    }
}

