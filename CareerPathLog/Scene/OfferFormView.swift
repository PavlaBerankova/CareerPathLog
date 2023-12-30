import SwiftUI

struct OfferFormView: View {
    @Environment(\.dismiss) 
    var backToListView
    @EnvironmentObject var model: OfferViewModel
    @State private var showAlert = false
    let dateOfInterview: LocalizedStringKey = "Date of interview"

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                offerInfoSection
                datesAndResponse
                if model.status == .interview && model.response {
                    jobInterviewsSection
                }
                offerTextEditor(with: $model.notes, header: "Notes")
                offerTextEditor(with: $model.fullTextOffer, header: "Full text offer")
            }
            .navigationTitle(LocalizedStringKey(model.selectedOffer?.companyName ?? "Add record"))
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
        .alert("You must fill \(model.titleAlert) field.", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - EXTENSION
extension OfferFormView {
    private var offerInfoSection: some View {
        Section {
            TextField("Company name", text: $model.companyName)
            TextField("Job title", text: $model.jobTitle)
            TextField("URL offer", text: $model.urlOffer)
            TextField("Salary", text: $model.salary)
        } header: {
            Text("Info")
        }
    }

    private var datesAndResponse: some View {
        Group {
            Section {
                DatePicker(
                    selection: $model.dateOfSubmittedCV,
                    in: model.startingDate...model.endingDate,
                    displayedComponents: .date) {
                        Text("Date of submitted CV")
                    }
                Toggle("Response", isOn: $model.response)
                if model.response {
                    DatePicker(
                        selection: $model.dateOfResponse,
                        in: model.startingDate...model.endingDate,
                        displayedComponents: .date) {
                            Text("Date of response")
                        }

                    Section {
                        Picker("Type of response", selection: $model.status) {
                            Text(LocalizedStringKey("StatusPicker - no response"))
                                .tag(Status.noResponse)
                            Text(LocalizedStringKey("StatusPicker - interview"))
                                .tag(Status.interview)
                            Text(LocalizedStringKey("StatusPicker - accepted"))
                                .tag(Status.accepted)
                            Text(LocalizedStringKey("StatusPicker - rejected"))
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
                Toggle("1. round of interview", isOn: $model.firstRoundOfInterview)
                if model.firstRoundOfInterview {
                    DatePicker(
                        selection: $model.dateOfFirstRoundOfInterview,
                        in: model.startingDate...model.endingDate,
                        displayedComponents: .date) {
                            Text(dateOfInterview)
                        }
                }

                Toggle("2. round of interview", isOn: $model.secondRoundOfInterview)
                if model.secondRoundOfInterview {
                    DatePicker(
                        selection: $model.dateOfSecondRoundOfInterview,
                        in: model.startingDate...model.endingDate,
                        displayedComponents: .date) {
                            Text(dateOfInterview)
                        }
                }

                Toggle("3. round of interview", isOn: $model.thirdRoundOfInterview)
                if model.thirdRoundOfInterview {
                    DatePicker(
                        selection: $model.dateOfThirdRoundOfInterview,
                        in: model.startingDate...model.endingDate,
                        displayedComponents: .date) {
                            Text(dateOfInterview)
                        }
                }
            } header: {
                Text(LocalizedStringKey("Interview"))
            }
    }

    private func offerTextEditor(with offerText: Binding<String>, header: LocalizedStringResource) -> some View {
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
                Text("Save")
            }
        }
    }

    private func updateButton(for selectedOffer: JobOffer) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                if model.checkTextFieldIsNotEmpty() {
                    model.updateOffer(model.editedOffer(selectedOffer))
                    backToListView()
                } else {
                    showAlert.toggle()
                }
            } label: {
                Text("Update")
            }
        }
    }
}

// MARK: - PREVIEW
#Preview("Czech") {
    NavigationStack {
        OfferFormView()
            .environmentObject(OfferViewModel())
            .environment(\.locale, Locale(identifier: "cs"))
    }
}

#Preview("English") {
    NavigationStack {
        OfferFormView()
            .environmentObject(OfferViewModel())
            .environment(\.locale, Locale(identifier: "en"))
    }
}
