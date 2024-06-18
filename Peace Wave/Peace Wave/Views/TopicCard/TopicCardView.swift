//
//  TopicCardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct TopicCardView: View {
    var icon: String
    var title: String
    var detail: String
    var backgroundImage: String
    var screenSize: CGSize
    
    var body: some View {
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(width: screenSize.width * 0.4, height: screenSize.width * 0.4)
                .clipped()
                .cornerRadius(20)
                .shadow(radius: 5)
                .opacity(0.7)
            VStack(alignment: .leading) { // Left alignment
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.white.opacity(0.3)))
                    Spacer()
                }
                Spacer()
                Text(detail)
                    .font(.title2)
                    .foregroundColor(.white)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: screenSize.width * 0.4, height: screenSize.width * 0.4) 
        }
    }
}

#Preview {
    GeometryReader { geometry in
        TopicCardView(
            icon: "heart.circle",
            title: "Stress Monitor",
            detail: "Track Stress",
            backgroundImage: "background1",
            screenSize: geometry.size
        )
    }
}
