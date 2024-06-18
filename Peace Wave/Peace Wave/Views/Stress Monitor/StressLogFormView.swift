//
//  StressLogFormView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-05.
//

import SwiftUI
import CoreData

struct StressLogFormView: View {
    
    // CoreData context and presentation mode environment variables
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    // State variables for form inputs
    @State private var stressLevel: Int16 = 0
    @State private var trigger: String = "Work"
    @State private var mood: String = "Happy"
    @State private var sleepQuality: Int16 = 8
    @State private var physicalActivity: String = ""
    @State private var notes: String = ""
    
    // State variables for alert
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // Arrays for picker options
    let triggers = ["Work", "Family", "Health", "Finances", "Other"]
    let moods = ["Happy", "Sad", "Anxious", "Calm", "Angry"]
    
    // Custom initializer to remove navigation bar background and shadow
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        GeometryReader { geometry in // GeometryReader to get screen size
            NavigationView {
                VStack {
                    Form {
                        // Section for stress level input
                        Section(header: Text("Stress Level")) {
                            Slider(value: Binding(get: {
                                Double(stressLevel)
                            }, set: { newValue in
                                stressLevel = Int16(newValue)
                            }), in: 0...10, step: 1) // Slider for stress level
                            Text("Stress Level: \(stressLevel)") // Display current stress level
                        }
                        
                        // Section for details input
                        Section(header: Text("Details")) {
                            // Picker for trigger
                            Picker("Trigger", selection: $trigger) {
                                ForEach(triggers, id: \.self) { trigger in
                                    Text(trigger).tag(trigger)
                                }
                            }
                            // Picker for mood
                            Picker("Mood", selection: $mood) {
                                ForEach(moods, id: \.self) { mood in
                                    Text(mood).tag(mood)
                                }
                            }
                            // Slider for sleep quality
                            VStack(alignment: .leading) {
                                Text("Sleep Quality: \(sleepQuality) hours")
                                Slider(value: Binding(get: {
                                    Double(sleepQuality)
                                }, set: { newValue in
                                    sleepQuality = Int16(newValue)
                                }), in: 1...24, step: 1)
                            }
                            // Text editor for physical activity
                            VStack(alignment: .leading) {
                                Text("Physical Activity")
                                TextEditor(text: $physicalActivity)
                                    .frame(height: geometry.size.height * 0.2)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                            }
                            // Text editor for notes
                            VStack(alignment: .leading) {
                                Text("Notes")
                                TextEditor(text: $notes)
                                    .frame(height: geometry.size.height * 0.2)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                            }
                        }
                        
                        // Button to save stress log
                        Button(action: saveStressLog) {
                            Text("Save")
                                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                                .foregroundColor(.white)
                                .background(.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("New Stress Log")
            .navigationBarBackButtonHidden(true)
            
            // Alert for success or error messages
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    if alertTitle == "Success" {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view on success
                    }
                })
            }
        }
    }
    
    // Function to save the stress log
    private func saveStressLog() {
        let newLog = StressLog(context: viewContext)
        newLog.id = UUID()
        newLog.date = Date()
        newLog.stressLevel = stressLevel
        newLog.trigger = trigger
        newLog.mood = mood
        newLog.sleepQuality = sleepQuality
        newLog.physicalActivity = physicalActivity
        newLog.notes = notes
        
        do {
            try viewContext.save() // Save the context
            alertTitle = "Success"
            alertMessage = "Stress log has been saved successfully."
            showingAlert = true
        } catch {
            alertTitle = "Error"
            alertMessage = "There was an error saving the stress log: \(error.localizedDescription)"
            showingAlert = true
        }
    }
}

#Preview {
    StressLogFormView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
}

