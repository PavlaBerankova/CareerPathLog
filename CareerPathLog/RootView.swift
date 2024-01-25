import SwiftUI

struct RootView: View {
    init() {
        UITabBarItem.appearance().badgeColor = .black
    }

    var body: some View {
        NavigationStack {
            TabView {
                OfferListView()
                    .tabItem {
                        VStack {
                            Image.status.allSendCv
                            Text("Vše")
                        }
                    }

                    .badge(10)

                OfferListView()
                    .tabItem {
                        VStack {
                            Image.status.noResponse
                            Text("Bez odpovědi")
                        }
                    }
                    .badge(10)

                OfferListView()
                    .tabItem {
                        VStack {
                            Image.status.interview
                            Text("Pohovory")
                        }
                    }
                    .badge(10)

                OfferListView()
                    .tabItem {
                        VStack {
                            Image.status.accepted
                            Text("Nabídky")
                        }
                    }
                    .badge(5)

                OfferListView()
                    .tabItem {
                        VStack {
                            Image.status.rejected
                            Text("Zamítnuto")
                        }
                    }
                    .badge(10)
            }
        }
    }
}

#Preview {
    RootView()
}
