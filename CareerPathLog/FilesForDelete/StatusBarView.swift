import SwiftUI

struct StatusBarView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var model: OfferViewModel
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(Status.allCases, id: \.self) { status in
                StatusButtonView(
                    isSelected: model.selectedFilter == status,
                    status: status) {
                        model.selectedFilter = status
                        model.updateFilteredOffers(selectFilter: status)

                        // TEST - INFO
                        print(model.selectedFilter);
                        print(model.filteredOffers.count)
                        //////////////////////////////////
                    }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    StatusBarView()
        .padding(.horizontal)
        .environmentObject(OfferViewModel())
}
