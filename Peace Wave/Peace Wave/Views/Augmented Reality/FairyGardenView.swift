//
//  FairyGardenView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-06.
//

import SwiftUI
import ARKit
import RealityKit
import AVFoundation

struct FairyGardenView: View {
    
    @State private var audioPlayer: AVAudioPlayer? // Audio player for background sound
    
    var body: some View {
        ARViewContainerGarden() // Container for AR view
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
        guard let soundURL = Bundle.main.url(forResource: "Fairy-Tale", withExtension: "mp3") else {
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
struct ARViewContainerGarden: UIViewRepresentable {
    static var arView: ARView? // Static reference to the AR view
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        ARViewContainerGarden.arView = arView
        
        // Call the function to set up the skybox
        setupSkybox(for: arView)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    // Function to set up the skybox for the AR view
    func setupSkybox(for arView: ARView) {
        
        // Load the .usdz skybox model
        guard let skyboxURL = Bundle.main.url(forResource: "Fantasy_Town", withExtension: "usdz") else {
            print("Skybox model not found.")
            return
        }
        
        // Load the USDZ file as an entity
        let skyboxEntity: Entity
        do {
            skyboxEntity = try Entity.load(contentsOf: skyboxURL)
        } catch {
            print("Failed to load skybox entity: \(error.localizedDescription)")
            return
        }
        
        // Create an anchor entity and add the skybox entity
        let anchorEntity = AnchorEntity(world: [0, 0, 0])
        anchorEntity.addChild(skyboxEntity)
        
        // Add the anchor to the scene
        arView.scene.addAnchor(anchorEntity)
    }
}

#Preview {
    FairyGardenView()
}

