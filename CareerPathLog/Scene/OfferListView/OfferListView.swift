import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showSettingsView = false
    //@State private var selectedOffer: JobOffer?

    var body: some View {
        NavigationStack {
            Group {
                if model.jobOffers.isEmpty {
                    Text("Přidej firmu\nkliknutím na +")
                        .font(.largeTitle)
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

//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        showSettingsView.toggle()
//                    } label: {
//                        Image(systemName: "gear")
//                    }
//                }
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
