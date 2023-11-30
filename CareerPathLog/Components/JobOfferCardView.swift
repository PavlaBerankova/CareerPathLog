import SwiftUI

struct JobOfferCardView: View {
    // MARK: - PROPERTIES
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let notes: String?
    let dateOfSentCV: Date
    var statusTitle: String

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
        jobOfferCard
    }
}

extension JobOfferCardView {
    private var jobOfferCard: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            infoTitle
            infoRow
            statusText
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(backgroundColor.opacity(0.8))
        )
    }

    private var infoTitle: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text(companyName)
                    .font(.body)
                    .fontWeight(.bold)
                Text(jobTitle)
                    .font(.callout)
                    .lineLimit(2)
                    .fontWeight(.medium)
            }
            .foregroundStyle(textColor)
            Spacer()

            VStack {
                Text("\(dateOfSentCV.formatted(.dateTime.day().month().year()))")
                    .font(.callout)
                Spacer()
            }
        }
        .foregroundStyle(textColor)
    }

    private var infoRow: some View {
        VStack(alignment: .leading) {
            if let notes = notes {
                Text("Poznámka: \(notes)")
                    .font(.footnote)
                    .foregroundStyle(textColor)
                    .padding(.top, 10)
            }
        }
    }

    private var statusText: some View {
        HStack {
            Text(statusTitle)
                .font(.footnote)
                .padding(5)
                .padding(.horizontal, 5)
                .background(.gray.opacity(0.2))
                .cornerRadius(25)
                .foregroundStyle(textColor)
                .padding(.top, 10)
            Spacer()
        }
        .padding(.top, 5)
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        JobOfferCardView(
            companyName: "NoName",
            jobTitle: "iOS vývojář",
            urlOffer: "https://www.futured.app/job/ios-developer/",
            notes: "stáž",
            dateOfSentCV: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1))!,
            statusTitle: Status.noResponse.rawValue)
    }
    .padding(.horizontal)
}
