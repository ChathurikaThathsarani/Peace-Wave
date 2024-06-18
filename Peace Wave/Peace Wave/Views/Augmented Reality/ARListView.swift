//
//  ARListView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-06.
//

import SwiftUI

struct ARListView: View {
    
    // List of AR views
    let arViews = [
        ARViewItem(title: "Lotus Mediation", imageName: "Lotus-Flower", destination: AnyView(BreathingExerciseView())),
        ARViewItem(title: "Autumn Forest", imageName: "autumn_forest", destination: AnyView(AutumnForest())),
        ARViewItem(title: "Fairy Garden", imageName: "fairy_garden", destination: AnyView(FairyGardenView())),
        ARViewItem(title: "Calm Beach", imageName: "calm_beach", destination: AnyView(CalmBeachView())),
        ARViewItem(title: "Winter Night", imageName: "winter_night", destination: AnyView(WinterNight())),
        ARViewItem(title: "Space View", imageName: "space_view", destination: AnyView(SpaceView()))
    ]
    
    // Define a two-column grid layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                // Create a grid layout with the defined columns
                LazyVGrid(columns: columns, spacing: 20) {
                    // Iterate over the AR views
                    ForEach(arViews, id: \.title) { arView in
                        NavigationLink(destination: arView.destination) {
                            // Custom card view for each AR experience
                            ARCardView(title: arView.title, imageName: arView.imageName)
                                .frame(width: 160, height: 200)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Immersive Reality")
        }
    }
}

#Preview {
    ARListView()
}

