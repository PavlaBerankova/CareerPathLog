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
    var jobOfferRejected = false
}

