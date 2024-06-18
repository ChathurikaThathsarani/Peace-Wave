//
//  OnboardingPageView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-07.
//

import SwiftUI

struct OnboardingPageView: View {
    var image: String
    var title: String
    var description: String
    var screenSize: CGSize
    @Binding var currentPage: Int  // Binding to track the current page inde
    var pageIndex: Int
    
    var body: some View {
        VStack {
            Spacer()
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: screenSize.width * 0.8, height: screenSize.width * 0.8)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4)) // Add a border around the circle
                .shadow(radius: 10)
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 10)
            Spacer()
        }
    }
}

