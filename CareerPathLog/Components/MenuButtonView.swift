import SwiftUI

struct MenuButtonView: View {
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
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        MenuButtonView(title: "Notes", icon: Image.flags.english, action: { })
        MenuButtonView(title: "Notes", icon: Image.flags.czech, action: { })
        MenuButtonView(title: "Czech", icon: Image.menu.web, action: { })

    }
    .foregroundStyle(.black)
    .padding(.horizontal)
}
