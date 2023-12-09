import SwiftUI

struct ContactsView: View {
    let name: String?
    let email: String?
    let phone: String?

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack(spacing: 20) {
                    Image(systemName: "person.circle")
                    Image(systemName: "envelope")
                    Image(systemName: "phone")
                }
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(name ?? "-")")
                    if let email = email {
                        Link(destination: URL(string: email)!, label: {
                            Text("\(email)")
                        })
                    }
                    Text("\(phone ?? "-")")
                }
            }
        }
        .font(.title3)
        .padding(.top, 70)
    }
}

#Preview {
    ContactsView(name: "Pavla Beránková", email: "berankova@email.cz", phone: "739123456")
}
