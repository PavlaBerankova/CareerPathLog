import SwiftUI

struct AddOfferView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var model: OfferViewModel

    // MARK: PROPERTIES
    @State private var companyName = String()
    @State private var jobTitle = String()
    @State private var urlOffer = String()
    @State private var notes = String()

    @State private var shouldWorkRemotely = false

    @State private var dateOfSentCV = Date()

    @State private var answer = false
    @State private var dateOfReply = Date()

    @State private var firstRoundOfInterview = false
    @State private var dateOfFirstRoundOfInterview = Date()

    @State private var secondRoundOfInterview = false
    @State private var dateOfSecondRoundOfInterview = Date()

    let decision = ["přijat", "zamítnuto", "bez odpovědi"]
    @State private var selectedDecision = String()

    @State private var fullTextOffer = String()
    let startingDate = Date.distantPast
    let endingDate = Date.distantFuture

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Název firmy", text: $companyName)
                    TextField("Název pozice", text: $jobTitle)
                    TextField("URL inzerátu", text: $urlOffer)
                    TextField("Poznámka", text: $notes)
                } header: {
                    Text("Info")
                }

                Toggle("Možnost remote", isOn: $shouldWorkRemotely)

                Section {
                    DatePicker(
                        selection: $dateOfSentCV,
                        in: startingDate...endingDate,
                        displayedComponents: .date) {
                            Text("Odeslané CV")
                        }

                } header: {
                    Text("Datum")
                }

                Toggle("Odpověď", isOn: $answer)
                if answer {
                    DatePicker(
                        selection: $dateOfReply,
                        in: startingDate...endingDate,
                        displayedComponents: .date) {
                            Text("Datum odpovědi")
                        }
                }

                Section {
                    Toggle("Pozvání na 1. kolo pohovoru", isOn: $firstRoundOfInterview)
                    if firstRoundOfInterview {

                        DatePicker(
                            selection: $dateOfFirstRoundOfInterview,
                            in: startingDate...endingDate,
                            displayedComponents: .date) {
                                Text("1. kolo pohovoru")
                            }
                    }
                }

                Section {
                    Toggle("Pozvání na 2. kolo pohovru", isOn: $secondRoundOfInterview)
                    if secondRoundOfInterview {
                        DatePicker(
                            selection: $dateOfSecondRoundOfInterview,
                            in: startingDate...endingDate,
                            displayedComponents: .date) {
                                Text("2. kolo pohovoru")
                            }
                    }
                }

                    Picker("Rozhodnutí", selection: $selectedDecision) {
                        ForEach(decision, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)

                Section {
                    TextEditor(text: $fullTextOffer)
                } header: {
                    Text("Celý text inzerátu")
                }
            }
            .navigationTitle("Přidat záznam")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addOffer()
                        dismiss()
                    } label: {
                        Text("Uložit")
                    }
                }
            }
        }
    }

    func addOffer() {
        let newOffer = JobOffer(
            companyName: companyName,
            jobTitle: jobTitle,
            urlOffer: urlOffer,
            notes: notes,
            dateOfSentCV: dateOfSentCV,
            dateOfReply: dateOfReply,
            firstRoundOfInterview: dateOfFirstRoundOfInterview,
            secondRoundOfInterview: dateOfSecondRoundOfInterview,
            fullTextOffer: fullTextOffer)

        model.jobOffers.append(newOffer)
        print(model.jobOffers)

    }
}

// MARK: - PREVIEW
#Preview {
    AddOfferView(model: OfferViewModel())
}