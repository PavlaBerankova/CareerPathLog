import Foundation

class OfferViewModel: ObservableObject {
    @Published var jobOffers = [JobOffer]()
}
