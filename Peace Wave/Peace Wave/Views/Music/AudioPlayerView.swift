//
//  AudioPlayerView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-06.
//

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    
    var audio: Audio
    @StateObject private var audioManager = AudioManager() // Manages audio playback
    @State private var isPlaying: Bool = false
    @State private var playbackPosition: Double = 0
    @State private var duration: Double = 0
    @State private var timer: Timer? // Timer for updating playback position
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // Current horizontal size class of the view's environment
    @Environment(\.verticalSizeClass) var verticalSizeClass // Current vertical size class of the view's environment
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                ZStack {
                    VStack(alignment: .center) {
                        ZStack {
                            // Background image
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: min(geometry.size.width, geometry.size.height) * 0.4, height: min(geometry.size.width, geometry.size.height) * 0.4)
                                .background(
                                    Image("nature_background")
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                )
                                .clipShape(Circle())
                            
                            // Music note
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                                .frame(width: min(geometry.size.width, geometry.size.height) * 0.2, height: min(geometry.size.width, geometry.size.height) * 0.2)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        
                        Text(audio.title) // Title of the audio
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                            .frame(height: 100)
                        
                        Text("Unknown Author") // Placeholder for author name
                            .font(.title2)
                            .foregroundColor(.pink)
                            .padding(.bottom, 20)
                            .frame(height: 100)
                        
                        Spacer()
                        
                        // Slider to control playback position
                        Slider(value: $playbackPosition, in: 0...duration, onEditingChanged: { editing in
                            if !editing {
                                audioManager.seek(to: playbackPosition)
                            }
                        })
                        .padding()
                        
                        HStack {
                            Text(formatTime(playbackPosition)) // Display current playback time
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(formatTime(duration)) // Display total duration
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            
                            // Rewind button
                            Button(action: {
                                audioManager.rewind(by: 5)
                            }) {
                                Image(systemName: "backward.fill")
                                    .resizable()
                                    .frame(width: min(geometry.size.width, geometry.size.height) * 0.1, height: min(geometry.size.width, geometry.size.height) * 0.1)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // Play/Pause button
                            Button(action: {
                                if isPlaying {
                                    audioManager.pauseSound()
                                    stopTimer()
                                } else {
                                    audioManager.playSound(sound: audio.title)
                                    startTimer()
                                }
                                isPlaying.toggle()
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: min(geometry.size.width, geometry.size.height) * 0.2, height: min(geometry.size.width, geometry.size.height) * 0.2)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            // Forward button
                            Button(action: {
                                audioManager.forward(by: 5)
                            }) {
                                Image(systemName: "forward.fill")
                                    .resizable()
                                    .frame(width: min(geometry.size.width, geometry.size.height) * 0.1, height: min(geometry.size.width, geometry.size.height) * 0.1)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .onAppear {
                        audioManager.loadSound(sound: audio.title)
                        duration = audioManager.getDuration()
                        playbackPosition = audioManager.getCurrentTime()
                        startTimer()
                    }
                    .onDisappear {
                        audioManager.pauseSound()
                        stopTimer()
                    }
                    .padding()
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    
    // Start the timer to update playback position
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            playbackPosition = audioManager.getCurrentTime()
        }
    }
    
    // Stop the timer
    private func stopTimer() {
        timer?.invalidate()
    }
    
    // Format time in minutes and seconds
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    let context = Persistence.preview.container.viewContext
    let newAudio = Audio(title: "Water focused relaxing")
    
    return AudioPlayerView(audio: newAudio)
}

