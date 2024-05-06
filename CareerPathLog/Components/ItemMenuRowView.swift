import SwiftUI

struct ItemMenuRowView: View {
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
                    .padding(.leading)
                Spacer()
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        ItemMenuRowView(title: "English", icon: Image.flags.english, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        ItemMenuRowView(title: "Czech", icon: Image.flags.czech, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        ItemMenuRowView(title: "Open URL", icon: Image.menu.web, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
    }
    .foregroundStyle(.black)
    .padding(.horizontal)
}
