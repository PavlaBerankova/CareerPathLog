import SwiftUI

struct SettingsView: View {
@State private var showSignInView = false

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    LogScreenView(showSignInView: .constant(false))
                } label: {
                    Text("ODHLÁSIT")
                        .font(.headline)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("Yellow"))
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
            }
            Spacer()
                .navigationTitle("Nastavení")
        }

    }
}

#Preview {
    SettingsView()
}
