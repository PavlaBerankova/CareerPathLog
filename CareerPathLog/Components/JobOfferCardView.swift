import SwiftUI

struct JobOfferCardView<Content: View>: View {
    let jobOffer: JobOffer

    // MARK: - PROPERTIES
//    let companyName: String
//    let jobTitle: String
//    let salary: String?
//    let dateOfSentCv: Date
    // var statusTitle: String
    var statusSubtitle: String?
    var contentMenu: Content
    var overlayButtonAction: () -> Void

//    var numberOfDaysSinceSendingCv: Int //{
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: Date.now, to: dateOfSentCv)
//        return abs(components.day!)
//    }
    var textColor: Color {
        if jobOffer.status == Status.noResponse {
            if jobOffer.numberOfDaysSinceSendCV > 14 {
                return .white
            } else {
                return .black
            }
        } else {
            return .black
        }
    }
    var rowBackgroundColor: Color {
        if jobOffer.status == Status.noResponse {
            if jobOffer.numberOfDaysSinceSendCV > 14 {
                return .black
            } else {
                return .black.opacity(0.07)
            }
        } else {
            return .black.opacity(0.07)
        }
    }

    var statusBackgroundColor: Color {
        if jobOffer.status == Status.interview {
            return Color.yellow.opacity(0.3)
        } else if jobOffer.status == Status.accepted {
            return Color.green.opacity(0.3)
        } else if jobOffer.status == Status.rejected {
            return Color.red.opacity(0.3)
        } else if jobOffer.status == Status.noResponse {
            if jobOffer.numberOfDaysSinceSendCV > 14 {
                return Color.blue
            }
        }
        return Color.blue.opacity(0.1)
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
            .foregroundStyle(rowBackgroundColor.opacity(0.8))
            .overlay {
                Button {
                    overlayButtonAction()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .padding(.trailing, 80)
                        .foregroundStyle(.clear)

                }
            }
        )
    }
}

// MARK: - EXTENSION
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
                Text("\(jobOffer.dateOfSentCV.formattedDate())")
                    .font(.callout)
                    .bold()
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
            Text(jobOffer.statusText)
                .font(.footnote)
                .padding(5)
                .padding(.horizontal, 5)
                .background(statusBackgroundColor)
                .cornerRadius(25)
                .foregroundStyle(textColor)
                .padding(.top, 10)
            if statusSubtitle != nil {
                Text(statusSubtitle!)
                    .font(.footnote)
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(statusBackgroundColor)
                    .cornerRadius(25)
                    .foregroundStyle(textColor)
                    .padding(.top, 10)
            }
            Spacer()
        }
    }

    private var menuView: some View {
        Menu {
            contentMenu
        } label: {
            Image(systemName: "ellipsis")
                .font(.title2)
                .padding(.bottom, 10)
                .foregroundColor(textColor)
                .frame(width: 60, height: 50, alignment: .bottomTrailing)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        JobOfferCardView(jobOffer: JobOffer(companyName: "Google", jobTitle: "Tester", urlOffer: nil, salary: "40 000kč", notes: "Toto je poznámka", dateOfSentCV: Date.now, reply: false, dateOfReply: nil, firstRoundInterview: false, dateOfFirstRoundInterview: nil, secondRoundInterview: false, dateOfSecondRoundInterview: nil, thirdRoundInterview: false, dateOfThirdRoundInterview: nil, fullTextOffer: "Toto je celý text inzerátu"), contentMenu: Text(""), overlayButtonAction: { })
//        JobOfferCardView(companyName: "Google", jobTitle: "UX Designér", salary: "40 000kč", dateOfSentCv: Date.now, statusTitle: Status.noResponse.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { print("TAP")}, numberOfDaysSinceSendingCv: 10)
//        JobOfferCardView(companyName: "Google", jobTitle: "UX Designér", salary: "40 000kč", dateOfSentCv: Date.now, statusTitle: Status.noResponse.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { }, numberOfDaysSinceSendingCv: 20)
//        JobOfferCardView(companyName: "Apple", jobTitle: "iOS Developer", salary: "60 000kč", dateOfSentCv: Date.now, statusTitle: Status.accepted.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { }, numberOfDaysSinceSendingCv: 2)
//        JobOfferCardView(companyName: "Microsoft", jobTitle: "Tester", salary: nil, dateOfSentCv: Date.now, statusTitle: Status.rejected.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { }, numberOfDaysSinceSendingCv: 0)
//        JobOfferCardView(companyName: "Eprin", jobTitle: "C# developer", salary: "40 000kč", dateOfSentCv: Date.now, statusTitle: Status.interview.rawValue, statusSubtitle: "2. kolo", contentMenu: Text(""), overlayButtonAction: { }, numberOfDaysSinceSendingCv: 9)
    }
    .padding(.horizontal)
}

