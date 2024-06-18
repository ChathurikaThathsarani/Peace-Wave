//
//  OnboardingView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showHomeView = false // State variable to control the transition to the HomeView
    
    var body: some View {
        if showHomeView {
            HomeView()
        } else {
            GeometryReader { geometry in // GeometryReader to get the screen size
                VStack {
                    TabView(selection: $currentPage) { // TabView to display the onboarding pages
                        OnboardingPageView(image: "onboarding1", title: "Welcome to Peace Wave", description: "Find your inner peace and calm with guided meditations and calming sounds.", screenSize: geometry.size, currentPage: $currentPage, pageIndex: 0)
                            .tag(0)
                        OnboardingPageView(image: "onboarding2", title: "Relax and Unwind Your Health", description: "Discover various techniques to help you relax and free from stress for better mental health.", screenSize: geometry.size, currentPage: $currentPage, pageIndex: 1)
                            .tag(1)
                        OnboardingPageView(image: "onboarding3", title: "Track Your Progress with Our App", description: "Keep track of your meditation journey and see your improvements over time.", screenSize: geometry.size, currentPage: $currentPage, pageIndex: 2)
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.horizontal, 20)
                    
                    HStack {
                        ForEach(0..<3) { index in // Loop to create indicators for each page
                            Circle()
                                .fill(index == currentPage ? Color.black : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding(.top)
                    
                    // Show next button
                    if currentPage < 2 {
                        Button(action: {
                            currentPage += 1
                        }) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.top, 20)
                        }
                    } else { // Show get started button
                        Button(action: {
                            showHomeView = true
                        }) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.top, 20)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    OnboardingView()
}

