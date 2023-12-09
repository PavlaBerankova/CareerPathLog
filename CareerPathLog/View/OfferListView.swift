import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false
    @State private var selectedFilter = Status.noResponse

    var body: some View {
        NavigationStack {
            statusBar
            Spacer()
                List {
                    ForEach(model.filter(by: selectedFilter), id: \.id) { offer in
                        JobOfferCardView(
                            jobOffer: offer,
                            statusTitle: model.statusText(offer),
                            statusSubtitle: model.roundOfInterview(offer),
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
                .navigationTitle("Career Path Log")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                Spacer()


                .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Menu {
                                    Section {
                                        MenuButton(title: Status.allStatus.rawValue, icon: "", action: {
                                            selectedFilter = Status.allStatus
                                        })
                                        MenuButton(title: Status.interview.rawValue, icon: "", action: {
                                            selectedFilter = Status.interview
                                        })
                                        MenuButton(title: Status.accepted.rawValue, icon: "", action: {
                                            selectedFilter = Status.accepted
                                        })
                                        MenuButton(title: Status.noResponse.rawValue, icon: "", action: {
                                            selectedFilter = Status.noResponse
                                        })
                                        MenuButton(title: Status.rejected.rawValue, icon: "", action: {
                                            selectedFilter = Status.rejected
                                        })
                                    } header: {
                                        Text("Filtrovat")
                                    }
                                } label: {
                                    Image(systemName: "line.3.horizontal.decrease.circle")
                                        .foregroundStyle(.black)
                                }
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
            StatusBarView(
                countSendCV: model.jobOffers.count,
                countAccepted: model.jobOffers.filter { ($0.status == .accepted) }.count,
                countRejected: model.jobOffers.filter { ($0.status == .rejected) }.count,
                countInterview: model.jobOffers.filter { ($0.status == .interview) }.count
            )
            .padding(.top)
        }

        private func menuButtons(_ offer: JobOffer) -> some View {
            Group {
                MenuButton(title: "Upravit záznam", icon: "square.and.pencil", action: {
                    model.selectedOffer = offer
                    showAddView.toggle()
                })
                MenuButton(title: "Přejít na inzerát", icon: "globe", action: {
                    model.selectedOffer = offer
                    if let urlOffer = model.selectedOffer?.urlOffer, !urlOffer.isEmpty {
                        UIApplication.shared.open(URL(string: urlOffer)!)
                    } else {
                        showingAlert.toggle()
                    }
                })
                MenuButton(title: "Zobrazit poznámku", icon: "note.text", action: {
                    model.selectedOffer = offer
                    showNotes.toggle()
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
