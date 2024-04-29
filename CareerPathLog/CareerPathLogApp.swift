import CoreData
import SwiftUI

@main
struct CareerPathLogApp: App {
  @Environment(\.scenePhase) var scenePhase
  // @StateObject private var coreDataStack = PersistenceController.shared
  // let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // RootView()
                JobOfferListView()
//                    .environmentObject(OfferViewModel())
//                    .environmentObject(Coordinator())
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
        }
        .onChange(of: scenePhase) { newPhase in
          if newPhase == .background {
              PersistenceController.shared.saveContext()
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
