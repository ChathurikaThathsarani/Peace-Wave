import CoreData

struct Persistence {
    static let shared = Persistence()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    static var preview: Persistence = {
        let result = Persistence(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Create sample StressLog data
        let newLog = StressLog(context: viewContext)
        newLog.id = UUID()
        newLog.date = Date()
        newLog.stressLevel = 5
        newLog.trigger = "Sample Trigger"
        newLog.mood = "Happy"
        newLog.sleepQuality = 8
        newLog.physicalActivity = "Walking"
        newLog.notes = "Sample notes"
        
        // Create sample Exercise data
        let newExercise = Exercise(context: viewContext)
        newExercise.id = UUID()
        newExercise.type = "Breath"
        newExercise.duration = 15
        newExercise.intensity = "Low" // Adding intensity attribute
        newExercise.date = Date()
        newExercise.notes = "Sample exercise notes"

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
}

