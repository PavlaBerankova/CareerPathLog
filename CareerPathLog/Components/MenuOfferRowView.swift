import SwiftUI

struct MenuOfferRowView: View {
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
                icon
                    .resizable()
                    .scaledToFit()
                Text(title)
                // Spacer()
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        MenuOfferRowView(title: "English", icon: Image.flags.english, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        MenuOfferRowView(title: "Czech", icon: Image.flags.czech, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        MenuOfferRowView(title: "Open URL", icon: Image.menu.web, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
    }
    .foregroundStyle(.black)
    .padding(.horizontal)
}
