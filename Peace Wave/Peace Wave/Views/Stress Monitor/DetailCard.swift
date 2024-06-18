//
//  DetailCard.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI

struct DetailCard: View {
    var icon: String
    var title: String
    var value: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(color)
                .padding()

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.2)]), startPoint: .top, endPoint: .bottom) // Add a linear gradient
        )
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}

