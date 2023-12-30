import SwiftUI

class OfferViewModel: ObservableObject {
    @Published var jobOffers = [JobOffer]() {
        didSet {
            saveOffer()
            updateFilteredOffers(selectFilter: selectedFilter)
        }
    }

    @Published var filteredOffers = [JobOffer]()

    @Published var selectedOffer: JobOffer?
    @Published var selectedFilter = Status.noResponse
    @Published var showAddView = false

    @Published var companyName = String()
    @Published var jobTitle = String()
    @Published var urlOffer = String()
    @Published var salary = String()
    @Published var notes = String()
    @Published var dateOfSentCV = Date()
    @Published var reply = false
    @Published var dateOfReply = Date()
    @Published var firstRoundOfInterview = false
    @Published var dateOfFirstRoundOfInterview = Date()
    @Published var secondRoundOfInterview = false
    @Published var dateOfSecondRoundOfInterview = Date()
    @Published var thirdRoundOfInterview = false
    @Published var dateOfThirdRoundOfInterview = Date()
    @Published var selectedStatus = String()
    @Published var fullTextOffer = String()
    @Published var status: Status = .noResponse

    @Published var titleAlert: LocalizedStringResource = ""

    let startingDate = Date.distantPast
    let endingDate = Date.distantFuture

    init() {
        if let savedOffers = UserDefaults.standard.data(forKey: "Offers") {
            if let decodedOffers = try? JSONDecoder().decode([JobOffer].self, from: savedOffers) {
                jobOffers = decodedOffers
                return
            }
        }
        jobOffers = []

        clearForm()
    }

    func updateFilteredOffers(selectFilter: Status) {
        if selectFilter == .allStatus {
            filteredOffers = jobOffers.sorted { $0.dateOfSubmissionV > $1.dateOfSubmissionV }
        } else {
            filteredOffers = jobOffers.filter { $0.status == selectFilter }.sorted { $0.dateOfSubmissionV > $1.dateOfSubmissionV }
        }
    }

    func updateOffer(_ updatedOffer: JobOffer) {
        guard let index = jobOffers.firstIndex(where: { $0.id == updatedOffer.id }) else {
            return // Item not found
        }
        jobOffers[index] = updatedOffer
        // Save the updated array to UserDefaults
        saveOffer()
    }

    // Edit existing offer
    func editedOffer(_ selectedOffer: JobOffer) -> JobOffer {
        return JobOffer(id: selectedOffer.id,
                        companyName: companyName,
                        jobTitle: jobTitle,
                        urlOffer: urlOffer,
                        salary: salary,
                        notes: notes,
                        dateOfSubmissionV: dateOfSentCV,
                        response: reply,
                        dateOfResponse: dateOfReply,
                        firstRoundOfInterview: firstRoundOfInterview,
                        dateOfFirstRoundOfInterview: dateOfFirstRoundOfInterview,
                        secondRoundOfInterview: secondRoundOfInterview,
                        dateOfSecondRoundOfInterview: dateOfSecondRoundOfInterview,
                        thirdRoundOfInterview: thirdRoundOfInterview,
                        dateOfThirdRoundOfInterview: dateOfThirdRoundOfInterview,
                        fullTextOffer: fullTextOffer,
                        status: reply ? status : .noResponse // reset and update status to .noResponse when user toggle reply to false
        )
    }

    func saveOffer() {
        if let encodedData = try? JSONEncoder().encode(jobOffers) {
            UserDefaults.standard.set(encodedData, forKey: "Offers")
        }
    }

    func deleteFilteredOffer(at offsets: IndexSet) {
        for index in offsets {
            let deletedOffer = filteredOffers[index]

            // Remove from filteredOffers
            filteredOffers.remove(at: index)

            // Find the index in jobOffers
            if let indexInJobOffers = jobOffers.firstIndex(of: deletedOffer) {
                // Remove from jobOffers
                jobOffers.remove(at: indexInJobOffers)
                saveOffer()
            }
        }
    }

    func addOffer() {
        let newOffer = JobOffer(
            companyName: companyName,
            jobTitle: jobTitle,
            urlOffer: urlOffer,
            salary: salary,
            notes: notes,
            dateOfSubmissionV: dateOfSentCV,
            response: reply,
            dateOfResponse: dateOfReply,
            firstRoundOfInterview: firstRoundOfInterview,
            dateOfFirstRoundOfInterview: dateOfFirstRoundOfInterview,
            secondRoundOfInterview: secondRoundOfInterview,
            dateOfSecondRoundOfInterview: dateOfSecondRoundOfInterview,
            thirdRoundOfInterview: thirdRoundOfInterview,
            dateOfThirdRoundOfInterview: dateOfThirdRoundOfInterview,
            fullTextOffer: fullTextOffer,
            status: status
        )

        jobOffers.append(newOffer)
        updateFilteredOffers(selectFilter: selectedFilter)
    }

    // Fill the form with selecting offer
    func fetchOfferToForm(_ offer: JobOffer) {
        companyName = offer.companyName
        jobTitle = offer.jobTitle
        urlOffer = offer.urlOffer ?? ""
        salary = offer.salary ?? ""
        notes = offer.notes ?? ""
        dateOfSentCV = offer.dateOfSubmissionV
        reply = offer.response
        dateOfReply = offer.dateOfResponse ?? Date.now
        firstRoundOfInterview = offer.firstRoundOfInterview
        dateOfFirstRoundOfInterview = offer.dateOfFirstRoundOfInterview ?? Date.now
        secondRoundOfInterview = offer.secondRoundOfInterview
        dateOfSecondRoundOfInterview = offer.dateOfSecondRoundOfInterview ?? Date.now
        fullTextOffer = offer.fullTextOffer ?? ""
        status = offer.status
    }

    func clearForm() {
        selectedOffer = nil
        companyName = String()
        jobTitle = String()
        urlOffer = String()
        salary = String()
        notes = String()
        dateOfSentCV = Date()
        reply = false
        dateOfReply = Date()
        firstRoundOfInterview = false
        dateOfFirstRoundOfInterview = Date()
        secondRoundOfInterview = false
        dateOfSecondRoundOfInterview = Date()
        thirdRoundOfInterview = false
        dateOfThirdRoundOfInterview = Date()
        selectedStatus = String()
        fullTextOffer = String()
        status = .noResponse
    }

    func checkTextFieldIsNotEmpty() -> Bool {
        if companyName.isEmpty && jobTitle.isEmpty {
            titleAlert = "název firmy a pozice"
            return false
        } else if jobTitle.isEmpty {
            titleAlert = "název pozice"
            return false
        } else if companyName.isEmpty {
            titleAlert = "název firmy"
            return false
        } else {
            return true
        }
    }

    func totalCountForStatus(_ status: Status) -> Int {
        switch status {
        case .allStatus:
            return jobOffers.count
        case .noResponse:
            return jobOffers.filter { $0.status == .noResponse }.count
        case .interview:
            return jobOffers.filter { $0.status == .interview }.count
        case .accepted:
            return jobOffers.filter { $0.status == .accepted }.count
        case .rejected:
            return jobOffers.filter { $0.status == .rejected }.count
        }
    }

    func showingAddView(with offer: JobOffer) {
        selectedOffer = offer
        showAddView.toggle()
    }

    func titleTextBySelectedFilter() -> LocalizedStringKey {
        switch selectedFilter {
        case .allStatus:
            return "Oslovené firmy"
        case .noResponse:
            return "CV bez odpovědi"
        case .interview:
            return "Pozvání na pohovor"
        case .accepted:
            return "Pracovní nabídky"
        case .rejected:
            return "Zamítnuté inzeráty"
        }
    }
}
