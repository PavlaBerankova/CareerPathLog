import SwiftUI

struct OfferListView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var model: OfferViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false
    @State private var selectedLanguage = "cs"

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            statusBar
            jobOfferlist
        }
        .navigationTitle((model.titleTextBySelectedFilter()))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            plusButton
            languageButton
        }
        .alert("Odkaz na inzerát tu není.", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .sheet(isPresented: $model.showAddView) {
            coordinator.addOfferView
        }
        .sheet(isPresented: $showNotes) {
            coordinator.offerInfo(with: model.selectedOffer?.notes, type: "notes")
        }
        .sheet(isPresented: $showFulltextOffer) {
            coordinator.offerInfo(with: model.selectedOffer?.fullTextOffer, type: "fullTextOffer")
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
                .padding(.horizontal, 20)
        }

        private var jobOfferlist: some View {
            List {
                ForEach(model.filteredOffers, id: \.id) { offer in
                    JobOfferCardView(
                        jobOffer: offer,
                        contentMenu: menuButtons(offer),
                        overlayButtonAction: {
                            model.showingAddView(with: offer)
                        }
                    )
                }
                .onDelete(perform: model.deleteFilteredOffer)
            }
            .listStyle(.plain)
        }

        private func menuButtons(_ offer: JobOffer) -> some View {
            Group {
                MenuButtonView(title: "Upravit záznam", icon: Image.info.edit, action: {
                    model.showingAddView(with: offer)
                })
                MenuButtonView(title: "Přejít na inzerát", icon: Image.info.web, action: {
                    model.selectedOffer = offer
                    if let urlOffer = model.selectedOffer?.urlOffer, !urlOffer.isEmpty {
                        UIApplication.shared.open(URL(string: urlOffer)!)
                    } else {
                        showingAlert.toggle()
                    }
                })
                MenuButtonView(title: "Zobrazit poznámku", icon: Image.info.notes, action: {
                    model.selectedOffer = offer
                    showNotes.toggle()
                })
                MenuButtonView(title: "Celý text inzerátu", icon: Image.info.document, action: {
                    model.selectedOffer = offer
                    showFulltextOffer.toggle()
                })
            }
        }

        private var plusButton: some ToolbarContent {
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

        private var languageButton: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                   
                } label: {
                    Text(selectedLanguage)
                        .foregroundStyle(.black)
                        .bold()
                }
            }
        }
    }

// MARK: - PREVIEW
#Preview("Czech") {
    NavigationStack {
        OfferListView()
            .environmentObject(OfferViewModel())
            .environmentObject(Coordinator())
            .environment(\.locale, Locale(identifier: "cs"))
    }
}

#Preview("English") {
    NavigationStack {
        OfferListView()
            .environmentObject(OfferViewModel())
            .environmentObject(Coordinator())
            .environment(\.locale, Locale(identifier: "en"))
    }
}
