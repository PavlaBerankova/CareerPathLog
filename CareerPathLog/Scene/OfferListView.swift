import SwiftUI

struct OfferListView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var model: OfferViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false
    @State private var alertTitle: LocalizedStringKey = ""

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            statusBar
            jobOfferlist
        }
        .navigationTitle((model.selectedFilter.title))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            plusButton
            languageButton
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .sheet(isPresented: $model.showFormView) {
            coordinator.addOfferView
        }
        .sheet(isPresented: $showNotes) {
            coordinator.offerSheet(with: model.selectedOffer?.notes)
        }
        .sheet(isPresented: $showFulltextOffer) {
            coordinator.offerSheet(with: model.selectedOffer?.fullTextOffer)
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
                            model.showFormView(with: offer)
                        }
                    )
                }
                .onDelete(perform: model.deleteFilteredOffer)
            }
            .listStyle(.plain)
        }

        private func menuButtons(_ offer: JobOffer) -> some View {
            Group {
                // FIRST ROW - EDIT
                MenuButtonView(title: MenuItemRow.edit.title, icon: Image.menu.edit, action: {
                    model.showFormView(with: offer)
                })

                // SECOND ROW - URL
                MenuButtonView(title: MenuItemRow.url.title, icon: Image.menu.web, action: {
                    model.selectedOffer = offer
                    if let urlOffer = model.selectedOffer?.urlOffer, !urlOffer.isEmpty {
                        UIApplication.shared.open(URL(string: urlOffer)!)
                    } else {
                        alertTitle = AlertTitle.url.title
                        showingAlert.toggle()
                    }
                })

                // THIRD ROW - NOTES
                MenuButtonView(title: MenuItemRow.notes.title, icon: Image.menu.notes, action: {
                    model.selectedOffer = offer
                    if let notes = model.selectedOffer?.notes, !notes.isEmpty {
                        showNotes.toggle()
                    } else {
                        alertTitle = AlertTitle.notes.title
                        showingAlert.toggle()
                    }
                })

                // FOURTH ROW - FULLTEXT
                MenuButtonView(title: MenuItemRow.fullText.title, icon: Image.menu.document, action: {
                    model.selectedOffer = offer
                    if let fulltext = model.selectedOffer?.fullTextOffer, !fulltext.isEmpty {
                        showFulltextOffer.toggle()
                    } else {
                        alertTitle = AlertTitle.fulltext.title
                        showingAlert.toggle()
                    }
                })
            }
        }

        private var plusButton: some ToolbarContent {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    model.clearForm()
                    model.showFormView.toggle()

                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
        }

        private var languageButton: some ToolbarContent {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Section {
                        Text("Selection language")
                    }
                    Section {
                        MenuButtonView(title: "English", icon: Image.flags.english, action: { UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) })
                        MenuButtonView(title: "Czech", icon: Image.flags.czech, action: { UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) })
                    }
                } label: {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
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
