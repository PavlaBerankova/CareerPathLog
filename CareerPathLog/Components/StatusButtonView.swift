import SwiftUI

struct StatusButtonView: View {
    @State private var value = 0
    @State private var selectedSymbol = false

    let symbol: Image
    let count: Int
    var action: () -> Void

    var body: some View {
        Button {
            action()
            value += 2
            selectedSymbol.toggle()
        } label: {
            symbol
            .resizable()
            .scaledToFill()
            .padding()
            .font(.title)
            .frame(minWidth: 60, idealWidth: 62, maxWidth: 70, minHeight: 60, idealHeight: 63, maxHeight: 70)
            .foregroundColor(.black)
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
            .overlay(
                    NotificationCountView(value: count)
                )
        }
        .symbolEffect(.bounce, value: value)
        .font(.largeTitle)
    }
}

#Preview {
    HStack {
        StatusButtonView(symbol: Image.status.sending, count: 10, action: { })
        StatusButtonView(symbol: Image.status.noResponse, count: 5, action: { })
        StatusButtonView(symbol: Image.status.interview, count: 3, action: { })
        StatusButtonView(symbol: Image.status.accepted, count: 1, action: { })
        StatusButtonView(symbol: Image.status.rejected, count: 1, action: { })
    }
    .padding(.horizontal)
}
