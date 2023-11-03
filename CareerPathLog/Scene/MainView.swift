import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            Text("Main View")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
       
    }
}

#Preview {
    MainView()
}
