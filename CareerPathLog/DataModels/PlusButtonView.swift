import SwiftUI

struct PlusButtonView: View {
    @State private var start = false
    var action: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Button {
                start.toggle()
                action()

            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    PlusButtonView(action: { })
}
