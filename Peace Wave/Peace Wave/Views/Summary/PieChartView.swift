//
//  PieChartView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import SwiftUI
import Charts

struct PieChartView: View {
    var data: [PieChartData]
    
    var body: some View {
        Chart {
            ForEach(data, id: \.title) { entry in // Loop through the data
                SectorMark(
                    angle: .value("Value", entry.value), // Set angle based on value
                    innerRadius: .ratio(0.5),
                    angularInset: 2
                )
                .foregroundStyle(by: .value("Title", entry.title))  // Set color by title
                .annotation(position: .overlay, alignment: .center) {
                    Text(entry.title) // Display title
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(5)
                }
            }
        }
    }
}


