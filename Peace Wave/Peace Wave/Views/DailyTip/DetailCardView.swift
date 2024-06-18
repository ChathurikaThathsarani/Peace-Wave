//
//  DetailCardView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct DetailCardView: View {
    var icon: String
    var title: String
    var detail: String
    var gradientColors: [Color]
    var image: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 100)
                    .clipped()
                
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding([.top, .leading], 8)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(detail)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom) // Add gradient colors to bottom of the card
            )
            .frame(width: 200)
        }
        .cornerRadius(20)
        .frame(width: 200, height: 250)
        .shadow(radius: 5)
    }
}
