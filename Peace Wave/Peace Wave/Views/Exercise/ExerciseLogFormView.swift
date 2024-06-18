//
//  ExerciseLogFormView.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-06.
//

import SwiftUI
import CoreData

struct ExerciseLogFormView: View {
    @Environment(\.managedObjectContext) private var viewContext // CoreData context environment variable
    @Environment(\.presentationMode) var presentationMode // Presentation mode environment variable
    
    // State variables for form inputs
    @State private var type: String = "Breath"
    @State private var duration: Int16 = 0
    @State private var intensity: String = "Low"
    @State private var date: Date = Date()
    @State private var notes: String = ""
    
    // State variables for alert
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // Arrays for picker options
    let exerciseTypes = ["Breath", "Meditate", "Yoga", "Stretch", "Walk"]
    let intensityLevels = ["Low", "Medium", "High"]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                Form {
                    // Section for exercise details input
                    Section(header: Text("Exercise Details")) {
                        // Picker for exercise type
                        Picker("Type", selection: $type) {
                            ForEach(exerciseTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        // HStack for duration input
                        HStack {
                            Text("Duration (minutes)")
                            Spacer()
                            TextField("0", value: $duration, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 80)
                        }
                        // Picker for intensity level
                        Picker("Intensity", selection: $intensity) {
                            ForEach(intensityLevels, id: \.self) { level in
                                Text(level).tag(level)
                            }
                        }
                        // DatePicker for date selection
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                        // TextEditor for notes input
                        VStack(alignment: .leading) {
                            Text("Notes")
                            TextEditor(text: $notes)
                                .frame(height: geometry.size.height * 0.2)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        }
                    }
                    
                    // Button to save the exercise log
                    Button(action: saveExerciseLog) {
                        Text("Save")
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                    }
                }
                .padding()
                // Alert for success or error messages
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                        if alertTitle == "Success" {
                            presentationMode.wrappedValue.dismiss() // Dismiss the view on success
                        }
                    })
                }
            }
            .navigationBarTitle("New Exercise")
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // Function to save the exercise log
    private func saveExerciseLog() {
        let newExercise = Exercise(context: viewContext)
        newExercise.id = UUID()
        newExercise.type = type
        newExercise.duration = duration
        newExercise.intensity = intensity
        newExercise.date = date
        newExercise.notes = notes
        
        do {
            try viewContext.save() // Save the context
            alertTitle = "Success"
            alertMessage = "Exercise log has been saved successfully."
            showingAlert = true
        } catch {
            alertTitle = "Error"
            alertMessage = "There was an error saving the exercise log: \(error.localizedDescription)"
            showingAlert = true
        }
    }
}

#Preview {
    ExerciseLogFormView().environment(\.managedObjectContext, Persistence.preview.container.viewContext)
}

