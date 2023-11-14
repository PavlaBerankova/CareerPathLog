import SwiftUI

struct OfferCardView: View {
    // MARK: - PROPERTIES
    let date = Date.now
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
    var textColor: Color {
        if numberOfDaysSinceSendingCv <= 14{
            return Color.theme.blackColor
        }
        return Color.theme.whiteColor
    }
    var backgroundColor: Color {
        if numberOfDaysSinceSendingCv <= 14 {
            return Color.theme.mainColor.opacity(0.7)
        }
        return Color.theme.blackColor

    }

    // MARK: - BODY
    var body: some View {
            LazyVStack(alignment: .leading) {
                HStack {
                    // SQUARE WITH DATE
                    Text("\(dateOfSentCV.formatted(.dateTime.day().month()))\n\(dateOfSentCV.formatted(.dateTime.year()))")
                        .bold()
                        .foregroundStyle(textColor)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 0)
                            .border(textColor)
                            .foregroundStyle(.clear)
                        )

                    // COMPANY AND JOB TITLE
                    VStack(alignment: .leading) {
                        Text(companyName)
                            .font(.title)
                        Text(jobTitle)
                    }
                    .foregroundStyle(textColor)
                    .padding(.leading, 20)
                }

                // INFO ROWS
                VStack(alignment: .leading, spacing: 10) {
                    if let urlOffer = urlOffer {
                        Link("Přejít na inzerát", destination: URL(string: urlOffer)!)
                            .foregroundStyle(Color.theme.link)
                    }
                    Text("Počet dní od odeslání: \(numberOfDaysSinceSendingCv)")
                    if let notes = notes {
                        Text("Poznámka: " + notes)
                    }

                    // BUTTONS
                    HStack {
                        Button {
                            print(Date.now)
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundStyle(.white)
                                .overlay {
                                    Text("Upravit")
                                        .font(.headline)
                                }

                        }
                        Button {

                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundStyle(.white)
                                .overlay {
                                    Text("Detail")
                                        .font(.headline)
                                }
                        }
                    }
                    .foregroundStyle(Color.theme.blackColor)
                }
                .foregroundStyle(textColor)
                .padding(.top)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(backgroundColor.opacity(0.8))
            )
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        OfferCardView(companyName: "Futured", jobTitle: "iOS vývojář", urlOffer: "https://www.futured.app/job/ios-developer/", dateOfSentCV: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1))!, notes: "stáž")
    }
    .padding(.horizontal)
}
