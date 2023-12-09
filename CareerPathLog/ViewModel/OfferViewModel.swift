import SwiftUI

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

    @Published var titleAlert = ""

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
                        dateOfSentCV: dateOfSentCV,
                        reply: reply,
                        dateOfReply: dateOfReply,
                        firstRoundInterview: firstRoundOfInterview,
                        dateOfFirstRoundInterview: dateOfFirstRoundOfInterview,
                        secondRoundInterview: secondRoundOfInterview,
                        dateOfSecondRoundInterview: dateOfSecondRoundOfInterview,
                        thirdRoundInterview: thirdRoundOfInterview,
                        dateOfThirdRoundInterview: dateOfThirdRoundOfInterview,
                        fullTextOffer: fullTextOffer,
                        status: status)
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
                salary: salary, 
                notes: notes,
                dateOfSentCV: dateOfSentCV,
                reply: reply,
                dateOfReply: dateOfReply,
                firstRoundInterview: firstRoundOfInterview,
                dateOfFirstRoundInterview: dateOfFirstRoundOfInterview,
                secondRoundInterview: secondRoundOfInterview,
                dateOfSecondRoundInterview: dateOfSecondRoundOfInterview,
                thirdRoundInterview: thirdRoundOfInterview,
                dateOfThirdRoundInterview: dateOfThirdRoundOfInterview,
                fullTextOffer: fullTextOffer,
                status: status
            )

            jobOffers.append(newOffer)
        }

    // Fill the form with existing offer
    func fetchOfferToForm(_ offer: JobOffer) {
            companyName = offer.companyName
            jobTitle = offer.jobTitle
            urlOffer = offer.urlOffer ?? ""
            salary = offer.salary ?? ""
            notes = offer.notes ?? ""
            dateOfSentCV = offer.dateOfSentCV
            reply = offer.reply
            dateOfReply = offer.dateOfReply ?? Date.now
            firstRoundOfInterview = offer.firstRoundInterview
            dateOfFirstRoundOfInterview = offer.dateOfFirstRoundInterview ?? Date.now
            secondRoundOfInterview = offer.secondRoundInterview
            dateOfSecondRoundOfInterview = offer.dateOfSecondRoundInterview ?? Date.now
            fullTextOffer = offer.fullTextOffer ?? ""
            status = offer.status
        }

    func numberOfDaysSinceSendingCv(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date.now)
        return abs(components.day!)
    }

    func declensionWordDay(_ number: Int) -> String {
        switch number {
        case 5... :
            return "\(number) dní"
        case 2...4 :
            return "\(number) dny"
        case 1 :
            return "\(number) den"
        default:
            return "\(number) dní"
        }
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

    func statusText(_ offer: JobOffer) -> String {
        switch offer.status {
        case .noResponse:
            return "\(declensionWordDay(numberOfDaysSinceSendingCv(from: offer.dateOfSentCV))) bez odpovědi"
        case .interview:
            return "pozvání na pohovor"
        case .rejected:
            return "zamítnuto"
        case .accepted:
           return "pracovní nabídka"
        case .allStatus:
            return "zobrazit vše"
        }
    }

    func roundOfInterview(_ offer: JobOffer) -> String? {
        if offer.firstRoundInterview && offer.secondRoundInterview && offer.thirdRoundInterview {
            return "3. kolo"
        } else if offer.firstRoundInterview && offer.secondRoundInterview {
            return "2. kolo"
        } else if offer.firstRoundInterview {
            return "1. kolo"
        }
        return nil
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

    func filter(by status: Status) -> [JobOffer] {
        if status == .allStatus {
            sortByDate(jobOffers)
        } else {
            sortByDate(jobOffers).filter { $0.status == status }
        }
    }

    func sortByDate(_ jobOffer: [JobOffer]) -> [JobOffer] {
        jobOffer.sorted { $0.dateOfSentCV > $1.dateOfSentCV }
    }
}

extension Date {
    func formattedDate() -> String {
        self.formatted(.dateTime.day().month().year())
    }
}
