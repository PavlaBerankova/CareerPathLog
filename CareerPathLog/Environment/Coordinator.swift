import SwiftUI

final class Coordinator: ObservableObject {
    func addUpdateOfferView(with offer: JobOfferEntity?) -> some View {
        AddUpdateOfferView(jobOffer: offer)
    }

    func infoText(with text: String?) -> some View {
            ScrollView {
                LazyVStack(alignment: .leading) {
                        Text(text ?? "")
                            .padding(25)
                }
                .padding(.top, 30)
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.medium, .large])
        }

    var statisticsView: some View {
        StatisticsView()
    }

    var profileView: some View {
        ProfileView()
    }
}
