import SwiftUI

// MARK: - FILTER VIEW
struct HorizontalFilterView: View {
    // MARK: PROPERTIES
    @Binding var selectedFilter: Status

    // MARK: BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Status.allCases, id: \.self) { status in
                    HorizontalFilterItem(
                        status: status,
                        isSelected: selectedFilter == status
                    )
                    .onTapGesture {
                        selectedFilter = status
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
    @EnvironmentObject var model: PersistenceController
    var status: Status
    var count: Int {
        if status == .allStatus {
            model.savedOffers.filter { $0.isArchived == false }.count
        } else if status == .archive {
            model.savedOffers.filter { $0.isArchived }.count
        } else {
            model.savedOffers.filter { $0.viewStatus == status && $0.isArchived == false }.count
        }
    }
    var isSelected: Bool = true

    // MARK: BODY
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(status.title)
                        .bold()
                    Text(String(count))
                }
                .font(.callout)
                .foregroundStyle(isSelected ? .accent : .accent.opacity(0.5))
                if isSelected {
                    Rectangle()
                        .frame(height: 2.0)
                        .foregroundColor(.accent)
                }
            }
    }
}

// MARK: - PREVIEW
#Preview("Filter View") {
    HorizontalFilterView(selectedFilter: .constant(.noResponse))
        .environmentObject(PersistenceController(forPreview: true))
}

#Preview("Filter Item") {
    HorizontalFilterItem(status: Status.allStatus)
        .environmentObject(PersistenceController(forPreview: true))
}

