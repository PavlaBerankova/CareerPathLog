import SwiftUI

final class Coordinator: ObservableObject {
    func addUpdateOfferView(with offer: JobOfferEntity?) -> some View {
        AddUpdateOfferView(jobOffer: offer)
    }
}
