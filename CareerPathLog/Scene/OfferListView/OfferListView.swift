import SwiftUI

struct OfferListView: View {
    @ObservedObject var model = OfferViewModel()
    @State private var showAddView = false

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
                .navigationTitle("Seznam oslovených firem")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }

        .sheet(isPresented: $showAddView) {
            AddOfferView(model: model)
        }
        .presentationDetents([.large])
    }
}

#Preview {
    OfferListView()
}
