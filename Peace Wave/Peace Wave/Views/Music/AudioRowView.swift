//
//  AudioRowView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI

struct AudioRowView: View {
    @Binding var audio: Audio // Binding to the audio object
    @Binding var currentlyPlayingAudio: Audio? // Binding to the currently playing audio
    @EnvironmentObject var audioManager: AudioManager // Access to the audio manager
    var backgroundImage: String // Background image for the row
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "music.note")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .opacity(0.7)
                Text(audio.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                // Play/Pause button
                Button(action: {
                    if currentlyPlayingAudio == audio {
                        audioManager.pauseSound()
                        currentlyPlayingAudio = nil
                    } else {
                        audioManager.playSound(sound: audio.title)
                        currentlyPlayingAudio = audio
                    }
                }) {
                    Image(systemName: currentlyPlayingAudio == audio ? "pause.circle" : "play.circle")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            )
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .frame(width: 300)
        .padding(.vertical, 5)
    }
}


