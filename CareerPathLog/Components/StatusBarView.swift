import SwiftUI

struct StatusBarView: View {
    // @Binding var selectedStatus: Status
    @EnvironmentObject var model: OfferViewModel

    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(Status.allCases, id: \.self) { status in
                StatusButtonView(
                    isSelected: model.selectedFilter == status,
                    status: status) {
                        if status == .allStatus {
                            model.selectedFilter = .allStatus
                        } else {
                            model.selectedFilter = status
                            model.updateFilteredOffers(selectFilter: status)
                        }
                        print(model.selectedFilter);
                        print(model.filteredOffers)
                    }
            }
        }
    }
}

#Preview {
    StatusBarView()
        .padding(.horizontal)
        .environmentObject(OfferViewModel())
}
