import SwiftUI

struct JobOfferCardView: View {
    // MARK: - PROPERTIES
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let notes: String?
    let dateOfSentCV: Date
    var jobOfferRejected = false

    var numberOfDaysSinceSendingCv: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date.now, to: dateOfSentCV)
        return abs(components.day!)
    }

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
        if jobOfferRejected {
            jobOfferCard
                .overlay {
                    Image("rejected")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .padding(20)
            }
        } else {
            jobOfferCard
        }
    }
}

extension JobOfferCardView {
    private var jobOfferCard: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 20) {
                // SQUARE WITH DATE
                VStack(alignment: .leading) {
                    Text("\(dateOfSentCV.formatted(.dateTime.day().month()))")
                    Text("\(dateOfSentCV.formatted(.dateTime.year()))")
                }
                    .font(.headline)
                    .bold()
                    .foregroundStyle(textColor)
                    //.padding()
//                    .background(RoundedRectangle(cornerRadius: 0)
//                        .border(textColor)
//                        .foregroundStyle(.clear)
//                    )

                // COMPANY AND JOB TITLE
                VStack(alignment: .leading) {
                    Text(companyName)
                        .font(.title2)
                        .bold()
                    Text(jobTitle)
                        .font(.footnote)
                }
                Spacer()
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(textColor)
                .padding(.trailing, 5)
                .padding(.bottom, 40)
            }
            .foregroundStyle(textColor)

            // INFO ROWS
            VStack(alignment: .leading, spacing: 10) {
                if let urlOffer = urlOffer {
                    Link("Přejít na inzerát", destination: URL(string: urlOffer)!)
                        .foregroundStyle(Color.theme.link)
                }
                Text("Počet dní od odeslání: \(numberOfDaysSinceSendingCv)")
//                if let notes = notes {
//                    Text("Poznámka: " + notes)
//                }
Divider()
                // PROGRESS BAR
                ProgressView(value: 0.25) {
                    Text("CV odesláno")
                        .font(.footnote)
                }
                //.padding(.vertical)
            }
            .foregroundStyle(textColor)
            //.padding(.top)
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
        JobOfferCardView(companyName: "NoName", jobTitle: "iOS vývojář", urlOffer: "https://www.futured.app/job/ios-developer/", notes: "stáž", dateOfSentCV: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1))!)
    }
    .padding(.horizontal)
}
