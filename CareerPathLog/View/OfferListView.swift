import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false
    @State private var showContacts = false

    var body: some View {
        NavigationStack {
            statusBar
            Spacer()
                    List {
                        ForEach(model.jobOffers, id: \.id) { offer in
                            JobOfferCardView(
                                jobOffer: offer,
                                statusTitle: model.statusText(offer),
                                contentMenu: menuButtons(offer))
//                            .onTapGesture {
//                                model.selectedOffer = offer
//                                print("Toto je zvolený offer \(String(describing: model.selectedOffer))")
//                                showAddView.toggle()
//                            }
                        }
                        .onDelete(perform: model.deleteOffer)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Seznam oslovených firem")
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
                    }
                }
// TODO: - FATAL ERROR (CardView change size, try set min and max height, width
//                ToolbarItem(placement: .topBarLeading) {
//                    EditButton()
//                }
            }
        }
        .alert("Odkaz na inzerát tu není.", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .sheet(isPresented: $showAddView) {
            AddOfferView()
        }
        .sheet(isPresented: $showNotes) {
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
        .sheet(isPresented: $showContacts) {
            ScrollView {
                if ((model.selectedOffer?.contactPerson) != nil) || ((model.selectedOffer?.email) != nil) || ((model.selectedOffer?.phoneNumber) != nil) {
                    ContactsView(name: model.selectedOffer?.contactPerson ?? "", email: model.selectedOffer?.email ?? "", phone: model.selectedOffer?.phoneNumber ?? "")
                    } else {
                        VStack(spacing: 50) {
                            Text("Žádné kontakty")
                                .bold()
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        .font(.title)
                        .opacity(0.2)
                        .padding(.top, 150)
                }
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
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
        StatusBarView(
            countSendCV: model.jobOffers.count,
            countAccepted: model.jobOffers.filter { ($0.status == .accepted) }.count,
            countRejected: model.jobOffers.filter { ($0.status == .rejected) }.count,
            countInterview: model.jobOffers.filter { ($0.status == .interview) }.count
        )
    }

    private func menuButtons(_ offer: JobOffer) -> some View {
        Group {
            MenuButton(title: "Upravit inzerát", icon: "square.and.pencil", action: {
                model.selectedOffer = offer
                showAddView.toggle()
            })
            MenuButton(title: "Přejít na inzerát", icon: "globe", action: {
                model.selectedOffer = offer
                model.openJobOfferUrl()
            })
            MenuButton(title: "Zobrazit poznámku", icon: "note.text", action: { 
                model.selectedOffer = offer
                showNotes.toggle()
            })
            MenuButton(title: "Kontakt", icon: "person.circle", action: {
                model.selectedOffer = offer
                showContacts.toggle()
            })
            MenuButton(title: "Celý text inzerátu", icon: "doc.plaintext", action: {
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
