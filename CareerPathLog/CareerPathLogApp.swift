import SwiftUI

@main
struct CareerPathLogApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(OfferViewModel())
                    .environmentObject(Coordinator())
            }
        }
    }
}
