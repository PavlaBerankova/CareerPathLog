import CoreData
import SwiftUI

// We need to set up a space in memory (context) to manage our data objects. SwiftUI has a really easy way in which we can do this.

@main
struct CareerPathLogApp: App {
  let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // RootView()
              JobOfferTestViewCoreDataView()
                    .environmentObject(OfferViewModel())
                    .environmentObject(Coordinator())
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

/*
 The environment modifier provides a specialproperty just for your managed object context.

 PersistentContainer is the property we created to hold our NSPersistentContainer.
 Persistent containers give us a managed object context (playground in memory) to make changes to data.
 The persistent container is created and the viewContext (managed object context) is added to the environment.
 Now the view has to access the managed object context so it can get some data and display it on the screen.
 */
