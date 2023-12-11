import SwiftUI

struct StatusButtonView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var value = 0
    var isSelected = false
    var symbol: Image {
            switch status {
            case .noResponse:
                Image(systemName: "clock.arrow.circlepath")
            case .allStatus:
                Image(systemName: "envelope")
            case .interview:
                Image(systemName: "person.bubble")
            case .accepted:
                Image(systemName: "checkmark.bubble")
            case .rejected:
                Image(systemName: "x.square")
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
                    .foregroundColor(Color("Gray1"))
            )
            .foregroundColor(.black)
           // .background(.gray.opacity(0.05))
            .frame(width: 63, height: 63)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(isSelected ? .black : .clear)

            )
//            .border(isSelected ? .black.opacity(0.4) : .clear, width: 0.8)
//            .cornerRadius(10)

        }
        .symbolEffect(.bounce, value: value)
        .font(.largeTitle)
        .overlay(
            NotificationCountView(value: count, status: status)
            )
    }
}

#Preview {
    HStack {
        StatusButtonView(isSelected: true, status: .allStatus, action: { })
        StatusButtonView(isSelected: true, status: .noResponse, action: { })
        StatusButtonView(isSelected: false, status: .interview, action: { })
        StatusButtonView(isSelected: false, status: .accepted, action: { })
        StatusButtonView(isSelected: true, status: .rejected, action: { })
    }
    .padding(.horizontal)
    .environmentObject(OfferViewModel())
}
