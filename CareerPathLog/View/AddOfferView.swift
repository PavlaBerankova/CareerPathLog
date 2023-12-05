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
                contacts
                dates
                if model.status == .interview {
                    jobInterviews
                }
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
            TextField("Mzda", text: $model.salary)
            TextField("Poznámka", text: $model.notes)
        } header: {
            Text("Info")
        }
    }

    private var contacts: some View {
        Section {
            TextField("Kontaktní osoba", text: $model.contactPerson)
            TextField("Email", text: $model.email)
            TextField("Telefon", text: $model.phoneNumber)
        } header: {
            Text("Kontakty")
        }
    }

    private var dates: some View {
        Group {
            Section {
                DatePicker(
                    selection: $model.dateOfSentCV,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("CV odesláno dne")
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
                            Text(Status.noResponse.rawValue)
                                .tag(Status.noResponse)
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
        }
    }

    private var jobInterviews: some View {
        Section {
            Toggle("1. kolo pohovoru", isOn: $model.firstRoundOfInterview)
            if model.firstRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfFirstRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("Datum pohovoru")
                    }
            }

            Toggle("2. kolo pohovoru", isOn: $model.secondRoundOfInterview)
            if model.secondRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfSecondRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("Datum pohovoru")
                    }
            }

            Toggle("3. kolo pohovoru", isOn: $model.thirdRoundOfInterview)
            if model.thirdRoundOfInterview {
                DatePicker(
                    selection: $model.dateOfThirdRoundOfInterview,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("Datum pohovoru")
                    }
            }
        } header: {
            Text("Výběrové řízení")
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
