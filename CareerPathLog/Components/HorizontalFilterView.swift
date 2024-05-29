import SwiftUI

// MARK: - FILTER VIEW
struct HorizontalFilterView: View {
    // MARK: PROPERTIES
    @Binding var selectedFilter: Status
    var count: [Status: Int]
    // var jobOffers: FetchedResults<JobOfferEntity>
//    var statusCounts: [Status: Int] {
//            var counts = [Status: Int]()
//            counts[.allStatus] = jobOffers.count
//            counts[.noResponse] = jobOffers.filter { $0.viewStatus == .noResponse }.count
//            counts[.interview] = jobOffers.filter { $0.viewStatus == .interview }.count
//            counts[.accepted] = jobOffers.filter { $0.viewStatus == .accepted }.count
//            counts[.rejected] = jobOffers.filter { $0.viewStatus == .rejected }.count
//            counts[.archive] = jobOffers.filter { $0.viewStatus == .archive }.count
//            return counts
//        }

    // MARK: BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Status.allCases, id: \.self) { status in
                    HorizontalFilterItem(
                        status: status,
                        count: count[status] ?? 0,
                        selectedFilter: selectedFilter
                    )
                    .onTapGesture {
                        selectedFilter = status
                        print(selectedFilter)
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - FILTER ITEM
struct HorizontalFilterItem: View {
    // MARK: PROPERTIES
    // let categoryTitle: Status
    // let jobOffers: FetchedResults<JobOfferEntity>
    var status: Status
    var count: Int
//    var itemsCount: Int {
//        switch status {
//        case .allStatus:
//            return jobOffers.count
//        case .noResponse:
//            return jobOffers.filter { $0.viewStatus == .noResponse }.count
//        case .interview:
//            return jobOffers.filter { $0.viewStatus == .interview }.count
//        case .accepted:
//            return jobOffers.filter { $0.viewStatus == .accepted }.count
//        case .rejected:
//            return jobOffers.filter { $0.viewStatus == .rejected }.count
//        case .archive:
//            return jobOffers.filter { $0.viewStatus == .archive }.count
//        }
//    }
    var selectedFilter: Status

    // MARK: BODY
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(status.title)
                    .bold()
                    .foregroundColor(selectedFilter == status ? .accent : .accent.opacity(0.5))
                Text(String(count))
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
//        selectedFilter: .constant(.interview),
//        jobOffers: nil)
//}

//#Preview("Filter Item") {
//    HorizontalFilterItem(
//        categoryTitle: Status.accepted.title,
//        jobOffers: nil,
//        status: .accepted,
//        selectedFilter: .constant(.interview))
//}

