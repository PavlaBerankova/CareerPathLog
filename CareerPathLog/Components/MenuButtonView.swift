import SwiftUI

struct MenuButtonView: View {
    let title: String
    let icon: String
    let action: () -> Void

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

#Preview {
    MenuButtonView(title: "Poznámka", icon: "pencil", action: { })
}
