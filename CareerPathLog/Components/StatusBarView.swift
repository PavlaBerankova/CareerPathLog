import SwiftUI

struct StatusBarView: View {
    let countSendCV: Int
    let countAccepted: Int
    let countRejected: Int
    let countInterview: Int

    var body: some View {
        HStack {
            VStack(spacing: 10) {
                Text("odesláno")
                    .font(.caption2)
                Text("\(countSendCV)")
                    .font(.headline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)


            VStack(spacing: 10) {
                Text("pohovory")
                    .font(.caption2)
                Text("\(countAccepted)")
                    .font(.headline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)

            VStack(spacing: 10) {
                Text("zamítnuto")
                    .font(.caption2)
                Text("\(countRejected)")
                    .font(.headline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)

            VStack(spacing: 10) {
                Text("nabídek")
                    .font(.caption2)
                Text("\(countInterview)")
                    .font(.headline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#Preview {
    StatusBarView(countSendCV: 0, countAccepted: 0, countRejected: 1, countInterview: 0)
}
