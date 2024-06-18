//
//  HomeView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            DashboardView()
        }.navigationBarTitle("")
            .navigationBarHidden(true)
        
    }
}

#Preview {
    HomeView()
}

