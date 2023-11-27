import Foundation

class OfferViewModel: ObservableObject {
    @Published var jobOffers = [JobOffer]() {
        didSet {
            saveOffer()
        }
    }
    @Published var selectedOffer: JobOffer? 
    @Published var companyName = String()
    @Published var jobTitle = String()
    @Published var urlOffer = String()
    @Published var notes = String()
    @Published var shouldWorkRemotely = false
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

    let startingDate = Date.distantPast
    let endingDate = Date.distantFuture
    let status = ["CV odesláno", "pozvání na pohovor", "zamítnuto", "1. týden bez odpovědi", "2. týdny bez odpovědi", "pracovní nabídka"]

    init() {
        if let savedOffers = UserDefaults.standard.data(forKey: "Offers") {
            if let decodedOffers = try? JSONDecoder().decode([JobOffer].self, from: savedOffers) {
                jobOffers = decodedOffers
                return
            }
        }
        jobOffers = []
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
        return JobOffer(id: selectedOffer.id, companyName: companyName, jobTitle: jobTitle, urlOffer: urlOffer, notes: notes, remote: shouldWorkRemotely, dateOfSentCV: dateOfSentCV, reply: reply, dateOfReply: dateOfReply, firstRoundInterview: firstRoundOfInterview, dateOfFirstRoundInterview: dateOfFirstRoundOfInterview, secondRoundInterview: secondRoundOfInterview, dateOfSecondRoundInterview: dateOfSecondRoundOfInterview, thirdRoundInterview: thirdRoundOfInterview, dateOfThirdRoundInterview: dateOfThirdRoundOfInterview, fullTextOffer: fullTextOffer)
    }

    func saveOffer() {
        if let encodedData = try? JSONEncoder().encode(jobOffers) {
            UserDefaults.standard.set(encodedData, forKey: "Offers")
        }
    }

    func deleteOffer(indexSet: IndexSet) {
        jobOffers.remove(atOffsets: indexSet)
        saveOffer()
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

            jobOffers.append(newOffer)
        }

    // Fill the form with existing offer
    func fetchOfferToForm(_ offer: JobOffer) {
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
}
