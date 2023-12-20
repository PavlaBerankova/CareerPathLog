import SwiftUI

struct StatusButtonView: View {
// MARK: - PROPERTIES
    @EnvironmentObject var model: OfferViewModel
    @State private var value = 0
    var isSelected = false
    var symbol: Image {
            switch status {
            case .noResponse:
                Image.status.noResponse
            case .allStatus:
                Image.status.allSendCv
            case .interview:
                Image.status.interview
            case .accepted:
                Image.status.accepted
            case .rejected:
                Image.status.rejected
            }
    }

    var count: Int {
        switch status {
        case .allStatus:
            return model.jobOffers.count
        case .noResponse:
            return model.jobOffers.filter { $0.status == .noResponse }.count
        case .interview:
            return model.jobOffers.filter { $0.status == .interview }.count
        case .accepted:
            return model.jobOffers.filter { $0.status == .accepted }.count
        case .rejected:
            return model.jobOffers.filter { $0.status == .rejected }.count
        }
    }
    var status: Status
    var action: () -> Void

    // MARK: - BODY
    var body: some View {
        Button {
            action()
            value += 2
        } label: {
            symbol
            .resizable()
            .scaledToFill()
            .padding()
            .font(.title)
            .frame(width: 60, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("White"))
            )
            .foregroundColor(.black)
            .frame(width: 63, height: 63)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(isSelected ? .black : .clear)
            )
        }
        .symbolEffect(.bounce, value: value)
        .font(.largeTitle)
        .overlay(
            NotificationCountView(value: count, status: status)
            )
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        StatusButtonView(isSelected: true, status: .allStatus, action: { })
        StatusButtonView(isSelected: true, status: .noResponse, action: { })
        StatusButtonView(isSelected: false, status: .interview, action: { })
        StatusButtonView(isSelected: false, status: .accepted, action: { })
        StatusButtonView(isSelected: true, status: .rejected, action: { })
    }
    .padding(.horizontal)
    .environmentObject(OfferViewModel())
}
