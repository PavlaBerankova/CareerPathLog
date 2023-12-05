import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showFulltextOffer = false
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            statusBar
            Spacer()

                    List {
                        ForEach(model.jobOffers, id: \.id) { offer in
                            JobOfferCardView(
                                companyName: offer.companyName,
                                jobTitle: offer.jobTitle,
                                urlOffer: offer.urlOffer,
                                notes: offer.notes,
                                dateOfSentCV: offer.dateOfSentCV,
                                statusTitle: model.statusText(offer)
                            )
                            .overlay(alignment: .bottomTrailing) {
                                Menu {
                                    Button(action: {
                                        model.selectedOffer = offer
                                        showAddView.toggle()
                                    }, label: {
                                        HStack {
                                            Text("Upravit záznam")
                                            Image(systemName: "square.and.pencil")
                                        }
                                    })

                                    Button(action: {
                                        model.selectedOffer = offer
                                        if let url = URL(string: model.selectedOffer?.urlOffer ?? "") {
                                            UIApplication.shared.open(url)
                                        } else {
                                            showingAlert.toggle()
                                            print(model.selectedOffer?.urlOffer)
                                        }
                                    }, label: {
                                        HStack {
                                            Text("Přejít na inzerát")
                                            Image(systemName: "globe")
                                        }
                                    })

                                    Button(action: {
                                        model.selectedOffer = offer
                                        showFulltextOffer.toggle()
                                    }, label: {
                                        HStack {
                                            Text("Celý text inzerátu")
                                            Image(systemName: "note")
                                        }
                                    })
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .padding(20)
                                        .padding(.bottom, 5)
                                        .foregroundStyle(.black)
                                }
                            }
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
        .sheet(isPresented: $showFulltextOffer) {
            ScrollView {
                if let fullTextoffer = model.selectedOffer?.fullTextOffer {
                    if !fullTextoffer.isEmpty {
                        Text(fullTextoffer)
                            .padding(25)
                    }  else {
                            Text("Není tu žádný text")
                                .font(.title)
                                .opacity(0.2)
                                .padding(.top, 150)
                    }
                }
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
            countInterview: model.jobOffers.filter { ($0.status == .interview) }.count)
    }
}

// MARK: - PREVIEW
#Preview {
        OfferListView()
            .environmentObject(OfferViewModel())
}
