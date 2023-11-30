import Foundation

struct JobOffer: Codable {
    var id = UUID()
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let notes: String?
    var remote: Bool
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
    case interview = "pozvání pohovor"
    case rejected = "zamítnuto"
    case accepted = "pracovní nabídka"
}

