import SwiftUI

struct JobOfferCardView<Content: View>: View {
    // MARK: - PROPERTIES
    let jobOffer: JobOffer
    var contentMenu: Content
    var overlayButtonAction: () -> Void
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
                return Color("White")
            }
        } else {
            return Color("White")
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
            if let statusSubtitle = jobOffer.statusSubtitle {
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

    private var menuView: some View {
        Menu {
            contentMenu
        } label: {
            Image.info.menuDots
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
        JobOfferCardView(jobOffer: JobOffers.mock.first!, contentMenu: Text("Content Menu"), overlayButtonAction: { })
        JobOfferCardView(jobOffer: JobOffers.mock.last!, contentMenu: Text("Content Menu"), overlayButtonAction: { })
    }
    .padding(.horizontal)
}
