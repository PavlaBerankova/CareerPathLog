import SwiftUI

struct StatusBarView: View {
    @EnvironmentObject var model: OfferViewModel
    // @Binding var selectedStatus: Status

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
