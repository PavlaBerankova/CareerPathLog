import SwiftUI

struct OfferListView: View {
    @EnvironmentObject var model: OfferViewModel
    @State private var showAddView = false
    @State private var showFulltextOffer = false

    var body: some View {
        NavigationStack {
            StatusBarView(countSendCV: model.cvSentCounter, countAccepted: model.acceptedCounter, countRejected: model.rejectedCounter, countInterview: model.interviewCounter)
            Spacer()

            Group {
                if model.jobOffers.isEmpty {
                    Text("Žádné záznamy")
                        .font(.title3)
                        .opacity(0.5)
                        .lineLimit(2)
                        .padding(.horizontal)
                    Spacer()
                } else {
                    List {
                        ForEach(model.jobOffers, id: \.id) { offer in
                            JobOfferCardView(
                                companyName: offer.companyName,
                                jobTitle: offer.jobTitle,
                                urlOffer: offer.urlOffer,
                                notes: offer.notes,
                                dateOfSentCV: offer.dateOfSentCV)
//                            .overlay(alignment: .bottomTrailing) {
//                                Menu {
//                                    Button(action: {
//                                        model.selectedOffer = offer
//                                        showAddView.toggle()
//                                    }, label: {
//                                        HStack {
//                                            Text("Upravit záznam")
//                                            Image(systemName: "square.and.pencil")
//                                        }
//                                    })
//                                    Button(action: {}, label: {
//                                        HStack {
//                                            Text("Přejít na inzerát")
//                                            Image(systemName: "globe")
//                                        }
//                                    })
//                                    Button(action: {
//                                        model.selectedOffer = offer
//                                        showFulltextOffer.toggle()
//                                    }, label: {
//                                        HStack {
//                                            Text("Celý text inzerátu")
//                                            Image(systemName: "note")
//                                        }
//                                    })
//                                } label: {
//                                    Image(systemName: "ellipsis")
//                                        .padding(20)
//                                        .padding(.bottom, 5)
//                                        .foregroundStyle(.black)
//                                }
//                            }
                            .onTapGesture {
                                model.selectedOffer = offer
                                print("Toto je zvolený offer \(String(describing: model.selectedOffer))")
                                showAddView.toggle()
                            }
                        }
                        .onDelete(perform: model.deleteOffer)
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
                        model.resetToDefaultValues()
                        showAddView.toggle()
                        print(model.selectedOffer.debugDescription)
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
            AddOfferView()
        }
        .sheet(isPresented: $showFulltextOffer) {
            if let selectedOffer = model.selectedOffer {
                Text(selectedOffer.fullTextOffer ?? "Nebyl přidán žádný text")
                    .padding()
            } 
        }
    }
}

#Preview {
        OfferListView()
            .environmentObject(OfferViewModel())
}
