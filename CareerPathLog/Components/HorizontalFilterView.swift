import SwiftUI

struct HorizontalFilterView: View {
    @Binding var selectedItem: FilterCategory
    var items: [FilterCategory]
    let itemsCount: Int?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(items, id: \.self) { item in
                    HorizontalFilterItem(filterCategory: item.rawValue, itemsCount: itemsCount, selectedFilter: $selectedItem)
                        .onTapGesture {
                            selectedItem = item
                        }
                }

            }
            .padding()
        }
    }
}

struct HorizontalFilterItem: View {
    let filterCategory: String
    let itemsCount: Int?
    @Binding var selectedFilter: FilterCategory

    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(LocalizedStringKey(filterCategory))
                    .bold()
                    .foregroundColor(selectedFilter.rawValue == filterCategory ? .accent : .accent.opacity(0.5))
                Text(String(itemsCount ?? 0))
                    .foregroundColor(selectedFilter.rawValue == filterCategory ? .accent : .accent.opacity(0.5))
            }
            .font(.callout)
            if selectedFilter.rawValue == filterCategory {
                Rectangle()
                    .frame(height: 2.0)
                    .foregroundColor(.accent)
            }
        }
    }
}

#Preview("Filter View") {
    HorizontalFilterView(selectedItem: .constant(.NoResponse), items: FilterCategory.allCases, itemsCount: 8)
}

#Preview("Filter Item") {
    HorizontalFilterItem(filterCategory: "No response", itemsCount: 10, selectedFilter: .constant(.NoResponse))
}

