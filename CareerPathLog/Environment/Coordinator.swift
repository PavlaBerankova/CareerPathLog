import SwiftUI

final class Coordinator: ObservableObject {
    var addOfferView: some View {
        OfferFormView()
            .presentationDragIndicator(.visible)
    }

    func offerSheet(with text: String?) -> some View {
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
}
