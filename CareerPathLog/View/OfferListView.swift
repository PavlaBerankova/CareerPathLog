import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false
    @State private var selectedFilter = Status.allStatus

    var body: some View {
        NavigationStack {
            VStack {
                statusBar
            }
            .padding(.horizontal, 20)
            Spacer()
                List {
                    ForEach(model.filter(by: selectedFilter), id: \.id) { offer in
                        JobOfferCardView(
                            companyName: offer.companyName,
                            jobTitle: offer.jobTitle,
                            salary: offer.salary,
                            dateOfSentCv: offer.dateOfSentCV,
                            statusTitle: model.statusText(offer),
                            statusSubtitle: model.roundOfInterview(offer),
                            contentMenu: menuButtons(offer))
                    }

                    .onDelete(perform: model.deleteOffer)
                }
                .listStyle(.plain)
                .navigationTitle("Career Path Log")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                Spacer()
                .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    model.clearForm()
                                    showAddView.toggle()
                                    print(model.selectedOffer.debugDescription)
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.black)
                                }
                        }
                }
                .alert("Odkaz na inzerát tu není.", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .sheet(isPresented: $showAddView) {
                    AddOfferView()
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
}

    // MARK: - EXTENSION
    extension OfferListView {
        private var statusBar: some View {
                HStack {
                    StatusButtonView(symbol: Image.status.sending, count: model.jobOffers.count, action: { selectedFilter = Status.allStatus })
                    StatusButtonView(symbol: Image.status.noResponse, count: model.jobOffers.filter { ($0.status == .noResponse) }.count, action: { selectedFilter = Status.noResponse })
                    StatusButtonView(symbol: Image.status.interview, count: model.jobOffers.filter { ($0.status == .interview) }.count, action: { selectedFilter = Status.interview })
                    StatusButtonView(symbol: Image.status.accepted, count: model.jobOffers.filter { ($0.status == .accepted) }.count, action: { selectedFilter = Status.accepted })
                    StatusButtonView(symbol: Image.status.rejected, count: model.jobOffers.filter { ($0.status == .rejected) }.count, action: { selectedFilter = Status.rejected })
                }
                .padding(.top)
        }

        private func menuButtons(_ offer: JobOffer) -> some View {
            Group {
                MenuButtonView(title: "Upravit záznam", icon: "square.and.pencil", action: {
                    model.selectedOffer = offer
                    showAddView.toggle()
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
    OfferListView()
        .environmentObject(OfferViewModel())
}
