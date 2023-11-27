import SwiftUI

struct StatusBarView: View {
    let countSendCV: Int
    let countInProcess: Int
    let countRejected: Int
    let countInterview: Int

    var body: some View {
        HStack {
            VStack {
                Text("odesláno")
                Text("\(countSendCV)")
                    .padding(.top, 5)
                    .font(.title2)
            }
            Divider()
            VStack {
                Text("v procesu")
                Text("\(countInProcess)")
                    .padding(.top, 5)
                    .font(.title2)
            }
            Divider()
            VStack {
                Text("zamítnuto")
                Text("\(countRejected)")
                    .padding(.top, 5)
                    .font(.title2)
            }
            Divider()
            VStack {
                Text("pohovory")
                Text("\(countInterview)")
                    .padding(.top, 5)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .border(Color.black.opacity(0.2))
        .shadow(radius: 10)
    }
}

#Preview {
    StatusBarView(countSendCV: 0, countInProcess: 0, countRejected: 1, countInterview: 0)
}
