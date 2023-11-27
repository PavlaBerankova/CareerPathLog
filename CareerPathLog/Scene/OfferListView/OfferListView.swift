import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showSettingsView = false
    //@State private var selectedOffer: JobOffer?

    var body: some View {
        NavigationStack {
            StatusBarView(countSendCV: 0, countInProcess: 0, countRejected: 0, countInterview: 0)
            Spacer()

            Group {
                if model.jobOffers.isEmpty {
                    Text("Žádné záznamy")
                        .font(.title3)
                        .opacity(0.5)
                        .lineLimit(2)
                        .padding(.horizontal)
                } else {
                    List {
                        ForEach(model.jobOffers, id: \.id) { offer in
                            JobOfferCardView(
                                companyName: offer.companyName,
                                jobTitle: offer.jobTitle,
                                urlOffer: offer.urlOffer,
                                notes: offer.notes,
                                dateOfSentCV: offer.dateOfSentCV)
                            .onTapGesture {
                                model.selectedOffer = offer
                                showAddView.toggle()
                            }
                        }
                        .onDelete(perform: model.deleteItem)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Seznam oslovených firem")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)

                }
            }
Spacer()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        model.selectedOffer = nil
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showAddView) {
            TestAddOfferView()
        }
        .presentationDetents([.large])
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
    }
}

#Preview {
        OfferListView()
            .environmentObject(OfferViewModel())
}
