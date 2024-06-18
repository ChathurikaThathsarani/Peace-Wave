//
//  AudioListView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-06.
//

import SwiftUI

struct AudioListView: View {
    
    @StateObject private var audioManager = AudioManager() // Manages audio playback
    @State private var audios = [ // List of audio tracks
        Audio(title: "Water Focused Relaxing"),
        Audio(title: "The Rockpool"),
        Audio(title: "Seeing the Light"),
        Audio(title: "Zen Meditation"),
        Audio(title: "Fall Asleep Like a Baby Relax Music blubon Relaxon"),
        Audio(title: "Relaxing Piano"),
        Audio(title: "Stress Relief Music"),
        Audio(title: "My Willowcare"),
        Audio(title: "Beautiful Stress Relief Ambient"),
        Audio(title: "Stress Relief Meditation")
    ]
    
    @State private var currentlyPlayingAudio: Audio? = nil // Track the currently playing audio
    private let backgroundImages = ["background1", "background2", "background3", "background4", "background5"] // Background images for the audio rows

    var body: some View {
        NavigationView {
            List {
                // Iterate over the audio tracks
                ForEach(audios.indices, id: \.self) { index in
                    NavigationLink(destination: AudioPlayerView(audio: audios[index])) {
                        // Custom row view for each audio track
                        AudioRowView(audio: $audios[index], currentlyPlayingAudio: $currentlyPlayingAudio, backgroundImage: backgroundImages[index % backgroundImages.count])
                            .environmentObject(audioManager) // Pass the audio manager to the row view
                            .frame(height: 80) // Fixed height for the card
                    }
                }
            }
            .navigationTitle("Listen")
        }
    }
}

#Preview {
    AudioListView()
}

