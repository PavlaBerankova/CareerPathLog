import SwiftUI

struct MenuButtonView: View {
    // MARK: - PROPERTIES
    let title: LocalizedStringResource
    let icon: String
    let action: () -> Void

    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: icon)
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    MenuButtonView(title: "Notes", icon: "pencil", action: { })
        .padding(.horizontal)
        .foregroundStyle(.black)
}
