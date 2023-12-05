import Foundation

struct JobOffer: Codable {
    var id = UUID()
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let salary: String?
    let notes: String?
    let contactPerson: String?
    let email: String?
    let phoneNumber: String?
    let dateOfSentCV: Date
    var reply: Bool
    let dateOfReply: Date?
    var firstRoundInterview: Bool
    let dateOfFirstRoundInterview: Date?
    var secondRoundInterview: Bool
    let dateOfSecondRoundInterview: Date?
    var thirdRoundInterview: Bool
    let dateOfThirdRoundInterview: Date?
    let fullTextOffer: String?
    var status: Status = .noResponse
    var jobOfferRejected = false
}

enum Status: String, Codable {
    case noResponse = "bez odpovědi"
    case interview = "pozvání na pohovor"
    case rejected = "zamítnuto"
    case accepted = "pracovní nabídka"
}

