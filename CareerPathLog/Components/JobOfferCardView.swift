import SwiftUI

struct JobOfferCardView<Content: View>: View {
    // MARK: - PROPERTIES
    let jobOffer: JobOffer
    var statusTitle: String
    var contentMenu: Content

    var numberOfDaysSinceSendingCv: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date.now, to: jobOffer.dateOfSentCV)
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
        LazyVStack(alignment: .leading, spacing: 0) {
            infoTitle
            HStack {
                statusText
                menuView
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(backgroundColor.opacity(0.8))
        )
    }
}

extension JobOfferCardView {
    private var infoTitle: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text(jobOffer.companyName)
                    .font(.body)
                    .fontWeight(.bold)
                Text(jobOffer.jobTitle)
                    .font(.callout)
                    .lineLimit(2)
                    .fontWeight(.medium)
            }
            .foregroundStyle(textColor)
            Spacer()

            VStack(alignment: .trailing) {
                Text("\(jobOffer.dateOfSentCV.formatted(.dateTime.day().month().year()))")
                    .font(.callout)
                if let salary = jobOffer.salary, !salary.isEmpty {
                    Text(salary)
                        .font(.footnote)
                }
                Spacer()
            }
        }
        .foregroundStyle(textColor)
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

    private var menuView: some View {
        Menu {
            contentMenu
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(textColor)
                .padding(.top)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        JobOfferCardView(jobOffer: JobOffer(companyName: "Google", jobTitle: "UX Designér", urlOffer: nil, salary: nil, notes: "Poznámka", contactPerson: "Alena Novotná", email: nil, phoneNumber: nil, dateOfSentCV: Date.now, reply: false, dateOfReply: nil, firstRoundInterview: false, dateOfFirstRoundInterview: nil, secondRoundInterview: false, dateOfSecondRoundInterview: nil, thirdRoundInterview: false, dateOfThirdRoundInterview: nil, fullTextOffer: nil), statusTitle: Status.noResponse.rawValue, contentMenu: Button("Test"){ })
    }
    .padding(.horizontal)
}
