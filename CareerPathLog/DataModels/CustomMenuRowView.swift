import SwiftUI

struct CustomMenuRowView: View {
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
        CustomMenuRowView(title: "English", icon: Image.flags.english, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        CustomMenuRowView(title: "Czech", icon: Image.flags.czech, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        CustomMenuRowView(title: "Open URL", icon: Image.menu.web, action: { })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
    }
    .foregroundStyle(.black)
    .padding(.horizontal)
}
