import SwiftUI

struct OfferCardView<Content: View>: View {
    // MARK: - PROPERTIES
    let jobOffer: JobOfferEntity
    var onTapOfferCard: () -> Void
    var onTapThreeDotButton: Content
    var textColor: Color {
        if jobOffer.viewStatus == .archive {
            return .white
        } else {
            return .black
        }
//        switch jobOffer.viewStatus {
//        case .noResponse:
//           if jobOffer.viewNumberOfDaysSinceSubmittedCv > 14 {
//                return .white
//            } else {
//                return .black
//            }
//        case .archive: return .white
//        default: return .black
//        }
    }

    var infoTagBackgroundColor: Color {
        if jobOffer.viewStatus == .archive {
            return .black.opacity(0.3)
        }
        return .gray.opacity(0.08)
    }
//
//    let noResponseColorDarker: Color = .blue
//    let noResponseColor: Color = .blue
//    let interviewColor: Color = .blue
//    let acceptedColor: Color = .blue
//    let rejectedColor: Color = .red

   // var textColor: Color = .accentColor

//    var rowBackgroundColor: Color {
//        if jobOffer.viewStatus == .noResponse {
//            if jobOffer.viewNumberOfDaysSinceSubmittedCv > 14 {
//                return noResponseColor
//            } else {
//                return noResponseColor
//            }
//        } else if jobOffer.viewStatus == .interview {
//            return interviewColor
//        } else if jobOffer.viewStatus == .accepted {
//            return acceptedColor
//        }
//        return rejectedColor
//    }

    var statusTextColor: Color {
            switch jobOffer.viewStatus {
            case .interview: return .darkPurple
            case .accepted: return .darkGreen
            case .rejected: return .darkRed
            case .archive: return .darkBlue
            default: return .accent
            }
    }

//    var statusBackgroundColor: Color {
//        switch jobOffer.viewStatus {
//        case .noResponse: return .blue
//        case .interview: return .yellow
//        case .accepted: return .green
//        default: return .red
//        }
//    }

    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    // FIRST HALF OF VSTACK
                    VStack(alignment: .leading) {
                        infoTitle
                        if !jobOffer.viewSalary.isEmpty {
                            salary
                        }
                        if !jobOffer.viewJobLocation.isEmpty {
                            jobOfferLocation
                        }

                        Spacer()
                        statusText
                    }

                    Spacer()

                    // SECOND HALF OF VSTACK
                    VStack(alignment: .trailing) {
                        dateOfSentCv
                        tagInfo
                        Spacer()
                        menuView
                    }
                }
            }
            .foregroundColor(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .background(
                ZStack {
                    if jobOffer.viewStatus == .archive {
                        Color.accentColor
                    } else {
                        LinearGradient(gradient:
                                        Gradient(colors: [.white, .white.opacity(0.0)]), startPoint: .top, endPoint: .bottom)

                        LinearGradient(gradient:
                                        Gradient(colors: [Color.purple.opacity(0.2), .blue.opacity(0.4)]), startPoint: .top, endPoint: .bottomTrailing)

                        Color.white.opacity(0.35)
                    }
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .cornerRadius(4))
            //.foregroundColor(rowBackgroundColor)

            Button {
                onTapOfferCard()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.clear)
            }
        }

    }
}

// MARK: - EXTENSION
extension OfferCardView {
    private var infoTitle: some View {
        Group {
            Text(jobOffer.viewJobTitle)
                .font(.body)
                .fontWeight(.bold)
                .lineLimit(2)
            Text(jobOffer.viewCompanyName)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }

    private var dateOfSentCv: some View {
        Text(jobOffer.viewDateOfSentCv)
            .font(.callout)
            .fontWeight(.medium)
    }

    private var tagInfo: some View {
        VStack(alignment: .trailing) {
            if jobOffer.viewJobLevel != .none {
                InfoTagView(title: jobOffer.viewJobLevel.rawValue, textColor: textColor, backgroundColor: infoTagBackgroundColor)
            }
            if jobOffer.viewTypesOfEmployment != .none {
                InfoTagView(title: jobOffer.viewTypesOfEmployment.rawValue, textColor: textColor, backgroundColor: infoTagBackgroundColor)
            }
            if jobOffer.viewWorkingArrangements != .none {
                InfoTagView(title: jobOffer.viewWorkingArrangements.rawValue, textColor: textColor, backgroundColor: infoTagBackgroundColor)
            }
        }
        .font(.callout)
    }

    private var salary: some View {
        HStack {
            Image(systemName: "dollarsign.circle")
            Text(jobOffer.viewSalary)
                .fontWeight(.bold)
        }
        .font(.caption)
        .padding(.top, 5)
        .foregroundColor(textColor.opacity(0.5))
    }

    private var jobOfferLocation: some View {
        HStack {
            Image(systemName: "map")
            Text(jobOffer.viewJobLocation)
        }
        .font(.caption)
        .padding(.top, 5)
        .foregroundColor(textColor.opacity(0.5))
    }

    private var statusText: some View {
        HStack {
            Group {
                Text(jobOffer.viewStatusText)
                if let statusSubtitle = jobOffer.viewInterviewStatusSubtitle {
                    Text(statusSubtitle)
                }
            }
            .font(.footnote)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.white.opacity(0.8))
            .foregroundColor(statusTextColor)
            .bold()
            .cornerRadius(8)
        .foregroundStyle(statusTextColor)
        }
    }

    private var menuView: some View {
        Menu {
            onTapThreeDotButton
        } label: {
            Image.menu.menuDots
                .font(.title2)
                .padding(.bottom, 10)
                .foregroundColor(textColor)
                .frame(width: 40, height: 40, alignment: .bottomTrailing)
        }
    }
}

// MARK: - PREVIEW
#Preview("OfferCardView") {
    ScrollView {
        VStack {
            OfferCardView(jobOffer: JobOffersEntities.mock[0], onTapOfferCard: { }, onTapThreeDotButton: Text("ContentMenu"))
            OfferCardView(jobOffer: JobOffersEntities.mock[1], onTapOfferCard: { }, onTapThreeDotButton: Text("ContentMenu"))
            OfferCardView(jobOffer: JobOffersEntities.mock[2], onTapOfferCard: { }, onTapThreeDotButton: Text("ContentMenu"))
            OfferCardView(jobOffer: JobOffersEntities.mock[3], onTapOfferCard: { }, onTapThreeDotButton: Text("ContentMenu"))
        }
        .padding(.horizontal)
    }
}
