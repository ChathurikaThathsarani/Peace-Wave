//
//  ContentView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
}
