import SwiftUI

struct RootView: View {
    @State private var showSignInView = false

    var body: some View {
        OfferListView()
//        ZStack {
//            NavigationStack {
//                LogScreenView(showSignInView: $showSignInView)
//            }
//            .fullScreenCover(isPresented: $showSignInView) {
//                OfferListView()
//            }
//        }
    }
}

#Preview {
    RootView()
}
