//
//  DashBoardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView (showsIndicators: false){
                VStack {
                    HStack {
                        Text("Hello there 👋")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal) // Padding to ensure space from the screen edges
                    
                    // Summary section
                    ZStack {
                        Image("summary")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width - 40, height: 150)
                            .clipped()
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .opacity(0.7)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Stress & Exercise Summary")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Month Report")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            NavigationLink(destination: StressSummaryView()) {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding()
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("Explore Activities")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading) // Add leading padding for left alignment
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Category section
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            NavigationLink(destination: StressLogListView()) {
                                TopicCardView(icon: "heart.circle", title: "Stress Monitor", detail: "Track Stress", backgroundImage: "dashboard-img1", screenSize: geometry.size)
                            }
                            NavigationLink(destination: ExerciseLogListView()) {
                                TopicCardView(icon: "figure.mind.and.body", title: "Calm Mind", detail: "Meditation", backgroundImage: "dashboard-img2", screenSize: geometry.size)
                            }
                        }
                        HStack(spacing: 20) {
                            NavigationLink(destination: ARListView()) {
                                TopicCardView(icon: "arkit", title: "AR Mind Relax", detail: "Relax", backgroundImage: "dashboard-img4", screenSize: geometry.size)
                            }
                            NavigationLink(destination: AudioListView()) {
                                TopicCardView(icon: "music.note", title: "Audio Sessions", detail: "Music", backgroundImage: "dashboard-img3", screenSize: geometry.size)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Daily tips section
                    VStack(spacing: 20) {
                        HStack {
                            Text("Daily Tips")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                DetailCardView(icon: "leaf.arrow.circlepath", title: "Tip 1", detail: "Take a few deep breaths and relax your mind.", gradientColors: [Color.purple, Color.blue], image: "tip1")
                                DetailCardView(icon: "figure.walk", title: "Tip 2", detail: "Go for a short walk to clear your head.", gradientColors: [Color.orange, Color.red], image: "tip2")
                                DetailCardView(icon: "music.note", title: "Tip 3", detail: "Listen to calming music or nature sounds.", gradientColors: [Color.yellow, Color.green], image: "tip3")
                                DetailCardView(icon: "moon.stars", title: "Tip 4", detail: "Ensure a good night’s sleep for better relax.", gradientColors: [Color.blue, Color.cyan], image: "tip4")
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.bottom, 50)
            }
            .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    DashboardView()
}
