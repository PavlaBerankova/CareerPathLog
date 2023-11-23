import SwiftUI

struct TestAddOfferView: View {
    @Environment(\.dismiss) var backToListView
    @EnvironmentObject var model: OfferViewModel

    // MARK: PROPERTIES
    @State private var companyName = String()
    @State private var jobTitle = String()
    @State private var urlOffer = String()
    @State private var notes = String()

    @State private var shouldWorkRemotely = false

    @State private var dateOfSentCV = Date()

    @State private var reply = false
    @State private var dateOfReply = Date()

    @State private var firstRoundOfInterview = false
    @State private var dateOfFirstRoundOfInterview = Date()

    @State private var secondRoundOfInterview = false
    @State private var dateOfSecondRoundOfInterview = Date()

    @State private var thirdRoundOfInterview = false
    @State private var dateOfThirdRoundOfInterview = Date()


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

                Toggle("Odpověď", isOn: $reply)
                if reply {
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
            .navigationTitle(model.selectedOffer?.companyName ?? "Přidat záznam")
            .toolbar {
                if let selectedOffer = model.selectedOffer {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            let updateOffer = JobOffer(
                                id: selectedOffer.id,
                                companyName: companyName,
                                jobTitle: jobTitle,
                                urlOffer: urlOffer,
                                notes: notes,
                                remote: shouldWorkRemotely,
                                dateOfSentCV: dateOfSentCV,
                                reply: reply,
                                dateOfReply: dateOfReply,
                                firstRoundInterview: firstRoundOfInterview,
                                dateOfFirstRoundInterview: dateOfFirstRoundOfInterview,
                                secondRoundInterview: secondRoundOfInterview,
                                dateOfSecondRoundInterview: dateOfSecondRoundOfInterview, 
                                thirdRoundInterview: thirdRoundOfInterview,
                                dateOfThirdRoundInterview: dateOfThirdRoundOfInterview,
                                fullTextOffer: fullTextOffer)

                            model.updateItem(updateOffer)
                            backToListView()
                        } label: {
                            Text("Update")
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addOffer()

                        } label: {
                            Text("Uložit")
                        }
                    }
                }
            }
        }
        .onAppear {
            if let selectedOffer = model.selectedOffer {
                fillInForm(with: selectedOffer)
            }
        }
    }

    //func updateOffer(_ offer: JobOffer) -> JobOffer {

        //return updatedOfferItem
    //}

    private func fillInForm(with offer: JobOffer) {
        companyName = offer.companyName
        jobTitle = offer.jobTitle
        urlOffer = offer.urlOffer ?? ""
        notes = offer.notes ?? ""
        shouldWorkRemotely = offer.remote
        dateOfSentCV = offer.dateOfSentCV
        reply = offer.reply
        dateOfReply = offer.dateOfReply ?? Date.now
        firstRoundOfInterview = offer.firstRoundInterview
        dateOfFirstRoundOfInterview = offer.dateOfFirstRoundInterview ?? Date.now
        secondRoundOfInterview = offer.secondRoundInterview
        dateOfSecondRoundOfInterview = offer.dateOfSecondRoundInterview ?? Date.now
        fullTextOffer = offer.fullTextOffer ?? ""
    }

    func addOffer() {
        let newOffer = JobOffer(
            companyName: companyName,
            jobTitle: jobTitle,
            urlOffer: urlOffer,
            notes: notes,
            remote: shouldWorkRemotely,
            dateOfSentCV: dateOfSentCV,
            reply: reply,
            dateOfReply: dateOfReply,
            firstRoundInterview: firstRoundOfInterview,
            dateOfFirstRoundInterview: dateOfFirstRoundOfInterview,
            secondRoundInterview: secondRoundOfInterview,
            dateOfSecondRoundInterview: dateOfSecondRoundOfInterview,
            thirdRoundInterview: thirdRoundOfInterview,
            dateOfThirdRoundInterview: dateOfThirdRoundOfInterview,
            fullTextOffer: fullTextOffer)

        model.jobOffers.append(newOffer)
        backToListView()
        print(model.jobOffers)

    }
}


// MARK: - PREVIEW
#Preview {
    TestAddOfferView()
        .environmentObject(OfferViewModel())
}
