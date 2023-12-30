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
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        MenuButtonView(title: "English", icon: Image.flags.english, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        MenuButtonView(title: "Czech", icon: Image.flags.czech, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        MenuButtonView(title: "Open URL", icon: Image.menu.web, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
    }
    .foregroundStyle(.black)
    .padding(.horizontal)
}
