import SwiftUI

// MARK: - FILTER VIEW
struct HorizontalFilterView: View {
    // MARK: PROPERTIES
    @Binding var selectedFilter: Status
    // var items: [FilterCategory]
    let jobOffers: FetchedResults<JobOfferEntity>

    // MARK: BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Status.allCases, id: \.self) { status in
                    HorizontalFilterItem(
                        categoryTitle: status.title,
                        jobOffers: jobOffers,
                        status: status,
                        selectedFilter: $selectedFilter)
                    .onTapGesture {
                        selectedFilter = status
                    }
                }
//                ForEach(items, id: \.self) { item in
//                    HorizontalFilterItem(
//                        filterCategory: item.rawValue,
//                        jobOffers: jobOffers,
//                        status: item,
//                        selectedFilter: $selectedItem
//                    )
//                    HorizontalFilterItem(
//                        filterCategory: item.rawValue, 
//                        jobOffers: jobOffers,
//                        itemsCount: itemsCount,
//                        selectedFilter: $selectedItem
//                    )
//                        .onTapGesture {
//                            selectedFilter = status
//                        }
                }
            }
            .padding()
        }
    }

// MARK: - FILTER ITEM
struct HorizontalFilterItem: View {
    // MARK: PROPERTIES
    let categoryTitle: LocalizedStringKey
    let jobOffers: FetchedResults<JobOfferEntity>
    var status: Status
    var itemsCount: Int {
        switch status {
        case .allStatus:
            return jobOffers.count
        case .noResponse:
            return jobOffers.filter { $0.viewStatus == .noResponse }.count
        case .interview:
            return jobOffers.filter { $0.viewStatus == .interview }.count
        case .accepted:
            return jobOffers.filter { $0.viewStatus == .accepted }.count
        case .rejected:
            return jobOffers.filter { $0.viewStatus == .rejected }.count
        case .archive:
            return jobOffers.filter { $0.viewStatus == .archive }.count
        }
    }
    @Binding var selectedFilter: Status

    // MARK: BODY
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(categoryTitle)
                    .bold()
                    .foregroundColor(selectedFilter == status ? .accent : .accent.opacity(0.5))
                Text(String(itemsCount))
                    .foregroundColor(selectedFilter == status ? .accent : .accent.opacity(0.5))
            }
            .font(.callout)
            if selectedFilter == status {
                Rectangle()
                    .frame(height: 2.0)
                    .foregroundColor(.accent)
            }
        }
    }
}

//// MARK: - PREVIEW
//#Preview("Filter View") {
//    HorizontalFilterView(
//        selectedItem: .constant(.NoResponse),
//        items: FilterCategory.allCases,
//        jobOffers: FetchedResults<JobOfferEntity>, 
//    )
//}
//
//#Preview("Filter Item") {
//    HorizontalFilterItem(
//        filterCategory: "Pohovor",
//        jobOffers: FetchedResults<JobOffersEntities>,
//        itemsCount: 3,
//        selectedFilter: .constant(.Interview)
//    )
//}

