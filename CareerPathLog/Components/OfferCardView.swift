import SwiftUI

struct OfferCardView: View {
    // MARK: PROPERTIES
    let date: Date
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let dateOfSentCV: Date
    var numberOfDaysSinceSendingCv: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date.now, to: dateOfSentCV)
        return abs(components.day!)
    }
    let notes: String?
    @State private var progressValue: Float = 0.0
    @State private var progressTotal: Float = 100.0

    // MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .shadow(radius: 10)
                .frame(maxWidth: .infinity)
                .frame(height: 300)

            LazyVStack(alignment: .leading) {
                HStack {
                    Text("\(date.formatted(.dateTime.day().month()))\n\(date.formatted(.dateTime.year()))")
                        .bold()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .border(.black)
                                .foregroundStyle(.white)
                        )
                    VStack(alignment: .leading) {
                        Text(companyName)
                            .font(.title)
                        Text(jobTitle)
                    }
                    .padding(.leading, 20)
                }
                VStack(alignment: .leading, spacing: 10) {
                    if let urlOffer = urlOffer {
                        Link("Přejít na inzerát", destination: URL(string: urlOffer)!)
                    }
                    Text("Počet dní od odeslání: \(numberOfDaysSinceSendingCv)") // computed
                    if let notes = notes {
                        Text("Poznámka: " + notes) // notes (model)
                    }

                    HStack {
                        Button {
                            print(Date.now)
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundStyle(.white)
                                .border(Color.black)
                                .overlay {
                                    Text("Upravit")
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }

                        }
                        Button {

                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundStyle(.white)
                                .border(Color.black)
                                .overlay {
                                    Text("Detail")
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                        }
                    }

                }
                .padding(.top)
            }
            .padding()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        OfferCardView(date: Date.now, companyName: "Futured", jobTitle: "iOS vývojář", urlOffer: "https://www.futured.app/job/ios-developer/", dateOfSentCV: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 1))!, notes: "stáž")
    }
    .padding(.horizontal)
}
