import SwiftUI

struct ContentMenuView: View {
    // MARK: - PROPERTIES
    let title: LocalizedStringKey
    let icon: Image
    let action: () -> Void

    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                icon
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        ContentMenuView(title: "English", icon: Image.flags.english, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        ContentMenuView(title: "Czech", icon: Image.flags.czech, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        ContentMenuView(title: "Open URL", icon: Image.menu.web, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
    }
    .foregroundStyle(.black)
    .padding(.horizontal)
}
