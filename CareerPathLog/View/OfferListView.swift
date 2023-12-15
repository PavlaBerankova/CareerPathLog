import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    // @State private var showAddView = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false
    @State private var tappedFilterButton = true

    var body: some View {
        NavigationStack {
            VStack {
                statusBar
            }
            .padding(.horizontal, 20)
            Spacer()
            Group {
                if model.selectedFilter == .allStatus {
                    List {
                        ForEach(model.jobOffers, id: \.id) { offer in
                            JobOfferCardView(
                                companyName: offer.companyName,
                                jobTitle: offer.jobTitle,
                                salary: offer.salary,
                                dateOfSentCv: offer.dateOfSentCV,
                                statusTitle: model.statusText(offer),
                                statusSubtitle: model.roundOfInterview(offer),
                                contentMenu: menuButtons(offer), 
                                overlayButtonAction: {
                                    model.showingAddView(with: offer)
                                })

                        }
                        .onDelete(perform: model.deleteOffer)
                        }
                    Spacer()
                } else {
                    List {
                        ForEach(model.filteredOffers, id: \.id) { offer in
                            JobOfferCardView(
                                companyName: offer.companyName,
                                jobTitle: offer.jobTitle,
                                salary: offer.salary,
                                dateOfSentCv: offer.dateOfSentCV,
                                statusTitle: model.statusText(offer),
                                statusSubtitle: model.roundOfInterview(offer),
                                contentMenu: menuButtons(offer),
                                overlayButtonAction: {
                                    model.showingAddView(with: offer)
                                }
                            )
                        }
                        .onDelete(perform: model.deleteFilteredOffer)
                    }
                    Spacer()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Career Path Log")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    print("This is main job offer: \(model.jobOffers.count)")
                    print("This is filtered job offers: \(model.filteredOffers.count)")
                } label: {
                    Text("PRINT OFFERS")
                        .foregroundStyle(.black)
                }
            }
                ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            model.clearForm()
                            model.showAddView.toggle()

                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                        }
                }
        }
        .alert("Odkaz na inzerát tu není.", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .sheet(isPresented: $model.showAddView) {
            AddOfferView()
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showNotes) {
            VStack(alignment: .leading) {
                if let notes = model.selectedOffer?.notes, !notes.isEmpty {
                    Text(notes)
                        .padding(25)
                } else {
                    VStack(spacing: 50) {
                        Text("Žádné poznámky")
                            .bold()
                        Image(systemName: "note.text")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .font(.title)
                    .opacity(0.2)
                    .padding(.top, 150)
                }
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showFulltextOffer) {
            ScrollView {
                if let fullTextoffer = model.selectedOffer?.fullTextOffer, !fullTextoffer.isEmpty {
                    Text(fullTextoffer)
                        .padding(25)
                } else {
                    VStack(spacing: 50) {
                        Text("Text inzerátu chybí")
                            .bold()
                        Image(systemName: "doc.plaintext")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .font(.title)
                    .opacity(0.2)
                    .padding(.top, 150)
                }
            }
            .presentationDragIndicator(.visible)
        }
    }
}

    // MARK: - EXTENSION
    extension OfferListView {
        private var statusBar: some View {
                VStack {
                    StatusBarView()
                }
                .padding(.top)
        }

        private func menuButtons(_ offer: JobOffer) -> some View {
            Group {
                MenuButtonView(title: "Upravit záznam", icon: "square.and.pencil", action: {
                    model.showingAddView(with: offer)
                })
                MenuButtonView(title: "Přejít na inzerát", icon: "globe", action: {
                    model.selectedOffer = offer
                    if let urlOffer = model.selectedOffer?.urlOffer, !urlOffer.isEmpty {
                        UIApplication.shared.open(URL(string: urlOffer)!)
                    } else {
                        showingAlert.toggle()
                    }
                })
                MenuButtonView(title: "Zobrazit poznámku", icon: "note.text", action: {
                    model.selectedOffer = offer
                    showNotes.toggle()
                })
                MenuButtonView(title: "Celý text inzerátu", icon: "doc.plaintext", action: {
                    model.selectedOffer = offer
                    showFulltextOffer.toggle()
                })
            }
        }
    }

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        OfferListView()
            .environmentObject(OfferViewModel())
    }

}

