import SwiftUI

struct FormOfferView: View {
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
                datesAndResponse
                if model.status == .interview && model.reply {
                    jobInterviewsSection
                }
                offerTextEditor(with: $model.notes, header: "Poznámky")
                offerTextEditor(with: $model.fullTextOffer, header: "Celý text inzerátu")
            }
            .navigationTitle(model.selectedOffer?.companyName ?? "Přidat záznam")
            .toolbarTitleDisplayMode(.large)
            .onAppear {
                if let selectedOffer = model.selectedOffer {
                    model.fetchOfferToForm(selectedOffer)
                }
            }
            .toolbar {
                if let selectedOffer = model.selectedOffer {
                    updateButton(for: selectedOffer)
                } else {
                    saveButton
                }
            }
        }
        .alert("Musíš vyplnit \(model.titleAlert).", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - EXTENSION
extension FormOfferView {
    private var offerInfoSection: some View {
        Section {
            TextField("Název firmy", text: $model.companyName)
            TextField("Název pozice", text: $model.jobTitle)
            TextField("URL inzerátu", text: $model.urlOffer)
            TextField("Mzda / plat", text: $model.salary)
        } header: {
            Text("Info")
        }
    }

    private var datesAndResponse: some View {
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

    private var jobInterviewsSection: some View {
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

    private func offerTextEditor(with offerText: Binding<String>, header: String) -> some View {
        Section {
            TextEditor(text: offerText)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 100, maxHeight: 400)
                .padding(.vertical)
        } header: {
            Text(header)
        }
    }

    private var saveButton: some ToolbarContent {
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

    private func updateButton(for selectedOffer: JobOffer) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                model.updateOffer(model.editedOffer(selectedOffer))
                backToListView()
            } label: {
                Text("Aktualizovat")
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        FormOfferView()
            .environmentObject(OfferViewModel())
    }
}
