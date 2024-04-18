import SwiftUI

struct OfferCardView: View {
    // MARK: - PROPERTIES
    let jobOffer: JobOfferEntity
    var threeDotButtonAction: () -> Void
    // var contentMenu: Content
    var textColor: Color {
        if jobOffer.viewStatus == .noResponse {
            if jobOffer.viewNumberOfDaysSinceSubmittedCv > 14 {
                return .white
            } else {
                return .black
            }
        } else {
            return .black
        }
    }

    var rowBackgroundColor: Color {
        if jobOffer.viewStatus == .noResponse {
            if jobOffer.viewNumberOfDaysSinceSubmittedCv > 14 {
                return .black
            } else {
                return Color("WhiteColor")
            }
        } else {
            return Color("WhiteColor")
        }
    }

    var statusBackgroundColor: Color {
        if jobOffer.viewStatus == .interview {
            return Color.yellow.opacity(0.3)
        } else if jobOffer.viewStatus == .accepted {
            return Color.green.opacity(0.3)
        } else if jobOffer.viewStatus == .rejected {
            return Color.red.opacity(0.3)
        } else if jobOffer.viewStatus == .noResponse {
            if jobOffer.viewNumberOfDaysSinceSubmittedCv > 14 {
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
                    // menuView
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(rowBackgroundColor.opacity(0.8))
            .overlay {
                Button {
                    threeDotButtonAction()
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
extension OfferCardView {
    private var infoTitle: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text(jobOffer.viewCompanyName)
                    .font(.body)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text(jobOffer.viewJobTitle)
                    .font(.callout)
                    .lineLimit(1)
                    .fontWeight(.medium)
            }
            .foregroundStyle(textColor)
            Spacer()

            VStack(alignment: .trailing) {
                Text(jobOffer.viewDateOfSentCv)
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
            Text(jobOffer.viewStatusText)
                .font(.footnote)
                .padding(5)
                .padding(.horizontal, 5)
                .background(statusBackgroundColor)
                .cornerRadius(25)
                .foregroundStyle(textColor)
                .padding(.top, 10)
            if let statusSubtitle = jobOffer.viewInterviewStatusSubtitle{
                Text(statusSubtitle)
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

//    private var menuView: some View {
//        Menu {
//            contentMenu
//        } label: {
//            Image.menu.menuDots
//                .font(.title2)
//                .padding(.bottom, 10)
//                .foregroundColor(textColor)
//                .frame(width: 60, height: 50, alignment: .bottomTrailing)
//        }
//    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        JobOfferCardView(jobOffer: JobOffers.mock.first!, contentMenu: Text("Content Menu"), overlayButtonAction: { })
        JobOfferCardView(jobOffer: JobOffers.mock.last!, contentMenu: Text("Content Menu"), overlayButtonAction: { })
    }
    .padding(.horizontal)
}
