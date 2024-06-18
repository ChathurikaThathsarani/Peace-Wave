//
//  BreathingExerciseView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI
import ARKit
import RealityKit
import AVFoundation

struct BreathingExerciseView: View {
    @State private var audioPlayer: AVAudioPlayer? // Audio player for background sound
    
    var body: some View {
        ARViewContainer() // Container for AR view
            .edgesIgnoringSafeArea(.all) // Extend AR view to the edges
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                playSound()
            }
            .onDisappear {
                stopSound()
            }
    }
    
    // Function to play background sound
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "Meditation-Bowls", withExtension: "mp3") else {
            print("Failed to load sound file")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    // Function to stop background sound
    func stopSound() {
        audioPlayer?.stop()
    }
}

// Container for the AR view
struct ARViewContainer: UIViewRepresentable {
    static var arView: ARView? // Static reference to the AR view
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero) // Create a new ARView instance
        ARViewContainer.arView = arView // Store the ARView instance in the static variable
        
        // Configure AR session with horizontal plane detection
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Add the delegate to handle plane anchors
        arView.session.delegate = context.coordinator
        
        return arView // Return the configured ARView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator() // Create an instance of the Coordinator
    }
    
    // Coordinator class to handle AR session events
    class Coordinator: NSObject, ARSessionDelegate {
        // Function called when new anchors are added to the AR session
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let arView = ARViewContainer.arView else { return } // Ensure ARView is available
            
            for anchor in anchors {
                // Check if the anchor is a plane anchor
                if let planeAnchor = anchor as? ARPlaneAnchor {
                    let anchorEntity = AnchorEntity(world: planeAnchor.transform) // Create an anchor entity at the plane's position
                    
                    // Load the model entity and add it to the anchor
                    if let modelEntity = try? Entity.load(named: "Lotus_Flower_with_Lillypad") {
                        anchorEntity.addChild(modelEntity) // Add the model to the anchor entity
                        arView.scene.addAnchor(anchorEntity) // Add the anchor entity to the scene
                    } else {
                        print("Failed to load breathing model")
                    }
                }
            }
        }
    }
}

struct BreathingExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingExerciseView()
    }
}

