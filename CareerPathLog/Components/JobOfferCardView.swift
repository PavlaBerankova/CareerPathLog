import SwiftUI

struct JobOfferCardView<Content: View>: View {
    // MARK: - PROPERTIES
    let companyName: String
    let jobTitle: String
    let salary: String?
    let dateOfSentCv: Date
    var statusTitle: String
    var statusSubtitle: String?
    var contentMenu: Content
    var overlayButtonAction: () -> Void

    var numberOfDaysSinceSendingCv: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date.now, to: dateOfSentCv)
        return abs(components.day!)
    }
    var textColor: Color {
        if numberOfDaysSinceSendingCv > 14 {
            return .white
        } else {
            return .black
        }
    }
    var rowBackgroundColor: Color {
        if numberOfDaysSinceSendingCv > 14 {
            return .black
        } else {
            return .black.opacity(0.07)
        }
    }

    var statusBackgroundColor: Color {
        if statusTitle == Status.interview.rawValue {
            return Color.yellow.opacity(0.3)
        } else if statusTitle == Status.accepted.rawValue {
            return Color.green.opacity(0.3)
        } else if statusTitle == Status.rejected.rawValue {
            return Color.red.opacity(0.3)
        } else if numberOfDaysSinceSendingCv > 14 {
            return Color.blue
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

            VStack(alignment: .trailing) {
                Text("\(dateOfSentCv.formattedDate())")
                    .font(.callout)
                    .bold()
                if let salary = salary, !salary.isEmpty {
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
        JobOfferCardView(companyName: "Google", jobTitle: "UX Designér", salary: "40 000kč", dateOfSentCv: Date.now, statusTitle: Status.noResponse.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { print("TAP")})
        JobOfferCardView(companyName: "Google", jobTitle: "UX Designér", salary: "40 000kč", dateOfSentCv: Date.now, statusTitle: Status.noResponse.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { })
        JobOfferCardView(companyName: "Apple", jobTitle: "iOS Developer", salary: "60 000kč", dateOfSentCv: Date.now, statusTitle: Status.accepted.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { })
        JobOfferCardView(companyName: "Microsoft", jobTitle: "Tester", salary: nil, dateOfSentCv: Date.now, statusTitle: Status.rejected.rawValue, statusSubtitle: nil, contentMenu: Text(""), overlayButtonAction: { })
        JobOfferCardView(companyName: "Eprin", jobTitle: "C# developer", salary: "40 000kč", dateOfSentCv: Date.now, statusTitle: Status.interview.rawValue, statusSubtitle: "2. kolo", contentMenu: Text(""), overlayButtonAction: { })
    }
    .padding(.horizontal)
}

