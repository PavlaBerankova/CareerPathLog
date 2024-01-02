import SwiftUI

struct RootView: View {
    var body: some View {
        OfferListView()
            .preferredColorScheme(.light)
    }
}

#Preview {
    RootView()
}
