import SwiftUI

struct OfferCardView<Content: View>: View {
    // MARK: - PROPERTIES
    let jobOffer: JobOfferEntity
    var onTapOfferCard: () -> Void
    var onTapThreeDotButton: Content

    let noResponseColorDarker: Color = .blue
    let noResponseColor: Color = .blue
    let interviewColor: Color = .blue
    let acceptedColor: Color = .blue
    let rejectedColor: Color = .red

    // var contentMenu: Content
    var textColor: Color {
        if jobOffer.viewStatus == .noResponse {
            if jobOffer.viewNumberOfDaysSinceSubmittedCv > 14 {
                return .black
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
                return noResponseColor
            } else {
                return noResponseColor
            }
        } else if jobOffer.viewStatus == .interview {
            return interviewColor
        } else if jobOffer.viewStatus == .accepted {
            return acceptedColor
        }
        return rejectedColor
    }

    var statusTextColor: Color {
        .black
        //    switch jobOffer.viewStatus {
        //    case "No response": return .noResponseColorDarker
        //    case "Interview": return .interviewColorDarker
        //    case "Accepted": return .green
        //    default: return .red
        //    }
    }

    var statusBackgroundColor: Color {
        switch jobOffer.viewStatus {
        case .noResponse: return .blue
        case .interview: return .yellow
        case .accepted: return .green
        default: return .red
        }
    }

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
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .background(
                ZStack {
                    LinearGradient(gradient:
                                    Gradient(colors: [.white, .white.opacity(0.0)]), startPoint: .top, endPoint: .bottom)

                    LinearGradient(gradient:
                                    Gradient(colors: [Color.purple.opacity(0.2), .cyan.opacity(0.4)]), startPoint: .top, endPoint: .bottomTrailing)

                    Color.white.opacity(0.35)
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
            )
            .foregroundColor(rowBackgroundColor)
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
                .padding(.bottom, 2)
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
                InfoTagView(title: jobOffer.viewJobLevel.rawValue)
            }
            InfoTagView(title: "full-time, part-time")
            InfoTagView(title: "remote/on-site")
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
        .foregroundColor(.secondary)
    }

    private var jobOfferLocation: some View {
        HStack {
            Image(systemName: "map")
            Text(jobOffer.viewJobLocation)
        }
        .font(.caption)
        .padding(.top, 5)
        .foregroundColor(.secondary)
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
            .background(Color.white.opacity(0.5))
            //        .overlay(
            //          RoundedRectangle(cornerRadius: 21)
            //            .strokeBorder(Color.black, lineWidth: 2)
            //        )
            .foregroundColor(statusTextColor)
            //.cornerRadius(21)
            .bold()
            .cornerRadius(8)
        .foregroundStyle(statusTextColor)
        }
        //.offset(x: 0, y: 25)
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
