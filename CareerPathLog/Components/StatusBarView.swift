import SwiftUI

struct StatusBarView: View {
    @Binding var selectedStatus: Status

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
                StatusButtonView(isSelected: selectedStatus == status, action: { selectedStatus = status }, status: status)
            }
        }
    }
}

#Preview {
    StatusBarView(selectedStatus: .constant(Status.interview))
        .padding(.horizontal)
}
