import SwiftUI

struct AddOfferView: View {
    @Environment(\.dismiss) 
    var backToListView
    @EnvironmentObject var model: OfferViewModel

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                offerInfoSection
                dateOfSendAndReplyCv
                dateOfInterviews
                statusPicker
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
                            model.addOffer()
                            backToListView()
                        } label: {
                            Text("Uložit")
                        }
                    }
                }
            }
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
                }
            } header: {
                Text("Datumy")
            }
        }
    }

    private var dateOfInterviews: some View {
        Section {
            Toggle("Pozvání na 1. kolo pohovoru", isOn: $model.firstRoundOfInterview)
            if model.firstRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfFirstRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("1. kolo pohovoru")
                    }
            }

            Toggle("Pozvání na 2. kolo pohovoru", isOn: $model.secondRoundOfInterview)
            if model.secondRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfSecondRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("2. kolo pohovoru")
                    }
            }

            Toggle("Pozvání na 3. kolo pohovoru", isOn: $model.thirdRoundOfInterview)
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

    private var statusPicker: some View {
        Section {
            Text("\(model.numberOfDaysSinceSendingCv()) dní bez odpovědi")
        } header: {
            Text("Status")
        }
    }

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
