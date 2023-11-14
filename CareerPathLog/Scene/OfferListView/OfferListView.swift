import SwiftUI

struct OfferListView: View {
    @ObservedObject var model = OfferViewModel()

    var body: some View {
        NavigationStack {
            List(model.jobOffers, id: \.id) { offer in
                JobOfferCardView(
                    companyName: offer.companyName,
                    jobTitle: offer.jobTitle,
                    urlOffer: offer.urlOffer,
                    notes: offer.notes, 
                    dateOfSentCV: offer.dateOfSentCV)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {

                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    OfferListView()
}
