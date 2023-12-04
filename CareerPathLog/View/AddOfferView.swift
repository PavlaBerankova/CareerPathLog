import SwiftUI

struct AddOfferView: View {
    @Environment(\.dismiss) 
    var backToListView
    @EnvironmentObject var model: OfferViewModel
    @State private var showAlert = false
    @State private var alertTitle = ""

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                offerInfoSection
                dateOfSendAndReplyCv
                if model.status == .interview {
                    dateOfInterviews
                }
                // statusPicker
                fulltextOfferEditor
            }
            .navigationTitle(model.selectedOffer?.companyName ?? "Přidat záznam")
            .onAppear {
                if let selectedOffer = model.selectedOffer {
                    model.fetchOfferToForm(selectedOffer)
                }
            }
            .toolbar {
                if let selectedOffer = model.selectedOffer {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            model.updateOffer(model.editedOffer(selectedOffer))
                            backToListView()
                        } label: {
                            Text("Aktualizovat")
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            if model.checkTextFieldIsNotEmpty() {
                                model.addOffer()
                                backToListView()
                            } else {
                                showAlert.toggle()
                            }
                        } label: {
                            Text("Uložit")
                        }
                    }
                }
            }
        }
        .alert("Musíš vyplnit \(model.titleAlert).", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - EXTENSION
extension AddOfferView {
    private var offerInfoSection: some View {
        Section {
            TextField("Název firmy", text: $model.companyName)
            TextField("Název pozice", text: $model.jobTitle)
            TextField("URL inzerátu", text: $model.urlOffer)
            TextField("Poznámka", text: $model.notes)
            Toggle("Možnost remote", isOn: $model.shouldWorkRemotely)
        } header: {
            Text("Info")
        }
    }

    private var dateOfSendAndReplyCv: some View {
        Group {
            Section {
                DatePicker(
                    selection: $model.dateOfSentCV,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("Odeslané CV")
                    }
                Toggle("Odpověď", isOn: $model.reply)
                if model.reply {
                    DatePicker(
                        selection: $model.dateOfReply,
                        in: model.startingDate...model.endingDate,
                        displayedComponents: .date) {
                            Text("Datum odpovědi")
                        }

                    Section {
                        Picker("Typ odpovědi", selection: $model.status) {
                            Text(Status.interview.rawValue)
                                .tag(Status.interview)
                            Text(Status.accepted.rawValue)
                                .tag(Status.accepted)
                            Text(Status.rejected.rawValue)
                                .tag(Status.rejected)
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
//                Picker("Status", selection: $model.status) {
//                    Text("\(model.numberOfDaysSinceSendingCv()) \(model.declensionWordDay()) " + Status.noResponse.rawValue) // -> 2 dny bez odpovědi, 0 dní bez odpovědi
//                        .tag(Status.noResponse)
//                    Text(Status.rejected.rawValue)
//                        .tag(Status.rejected)
//                    Text(Status.accepted.rawValue)
//                        .tag(Status.accepted)
//                }
//                .pickerStyle(.inline)
        }
    }

    private var dateOfInterviews: some View {
        Section {
            Toggle("1. kolo pohovoru", isOn: $model.firstRoundOfInterview)
            if model.firstRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfFirstRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("1. kolo pohovoru")
                    }
            }

            Toggle("2. kolo pohovoru", isOn: $model.secondRoundOfInterview)
            if model.secondRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfSecondRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("2. kolo pohovoru")
                    }
            }

            Toggle("3. kolo pohovoru", isOn: $model.thirdRoundOfInterview)
            if model.thirdRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfThirdRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("3. kolo pohovoru")
                    }
            }
        } header: {
            Text("Pohovory")
        }
    }

//    private var statusPicker: some View {
//        Section {
//            if let selectedOffer = model.selectedOffer {
//                Text(model.statusText(selectedOffer))
//            } else {
//                Text(Status.noResponse.rawValue)
//            }
//        } header: {
//            Text("Status")
//        }
//    }

    private var fulltextOfferEditor: some View {
        Section {
            TextEditor(text: $model.fullTextOffer)
        } header: {
            Text("Celý text inzerátu")
        }
    }
}

// MARK: - PREVIEW
#Preview {
    AddOfferView()
        .environmentObject(OfferViewModel())
}
