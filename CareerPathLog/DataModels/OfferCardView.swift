import SwiftUI

struct OfferCardView<Content: View>: View {
  // MARK: - PROPERTIES
  let jobOffer: JobOfferEntity
  var threeDotButtonAction: () -> Void
  var contentMenu: Content

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
    VStack(alignment: .leading, spacing: 10) {
      HStack(alignment: .top) {
        // FIRST HALF
        VStack(alignment: .leading) {
          infoTitle
          salary
            .foregroundColor(.secondary)
          jobOfferLocation
            .foregroundColor(.secondary)

          Spacer()
          HStack {
              statusText
          }
        }

        Spacer()

        // SECOND HALF
        VStack(alignment: .trailing) {
          dateOfSentCv
          tagInfo
          Spacer()
          menuView
        }
      }
      //      infoTitle
      //      tagInfo
      //
      //      HStack(alignment: .bottom) {
      //        VStack(alignment: .leading) {
      //          salary
      //          jobOfferLocation
      //          Spacer()
      //
      //        }
      //        .font(.footnote)
      //
      //         statusText
      //
      //
      //      }
      //      .foregroundColor(.secondary)


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
    .overlay {
                    Button {
                        threeDotButtonAction()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .padding(.trailing, 80)
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
      InfoTagView(title: "junior")
      InfoTagView(title: "full-time")
      // InfoTagView(title: "remote")
    }
    .font(.callout)
    // .padding(.top, 1)
  }

  private var salary: some View {
    HStack {
      Image(systemName: "dollarsign.circle")
      Text(jobOffer.viewSalary)
    }
    .font(.caption)
    .fontWeight(.bold)
    .padding(.vertical, 5)
  }

  private var jobOfferLocation: some View {
    HStack {
      Image(systemName: "map")
      Text("Brno")
    }
    .font(.caption)
  }

//    private var statusText: some View {
//        Group {
//            Text(jobOffer.viewStatusText)
//            if let statusSubtitle = jobOffer.viewStatusSubtitle {
//                Text(statusSubtitle)
//            }
//        }
//    }
  private var statusText: some View {
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
    //.offset(x: 0, y: 25)
  }



  private var menuView: some View {
      Menu {
          contentMenu
      } label: {
          Image.menu.menuDots
              .font(.title2)
              //.padding(.bottom, 10)
              .foregroundColor(textColor.opacity(0.5))
              .frame(width: 60, height: 50, alignment: .bottomTrailing)

      }
  }
}

// MARK: - PREVIEW
#Preview {
  ScrollView {
    VStack {
        OfferCardView(jobOffer: JobOffersEntities.mock[0], threeDotButtonAction: { }, contentMenu: Text("ContentMenu"))
        OfferCardView(jobOffer: JobOffersEntities.mock[1], threeDotButtonAction: { }, contentMenu: Text("ContentMenu"))
        OfferCardView(jobOffer: JobOffersEntities.mock[2], threeDotButtonAction: { }, contentMenu: Text("ContentMenu"))
        OfferCardView(jobOffer: JobOffersEntities.mock[3], threeDotButtonAction: { }, contentMenu: Text("ContentMenu"))
    }
    .padding(.horizontal)
  }
}
