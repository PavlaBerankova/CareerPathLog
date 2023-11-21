import Foundation

struct JobOffer: Codable {
    var id = UUID()
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let notes: String?
    let dateOfSentCV: Date
    let dateOfReply: Date?
    let firstRoundOfInterview: Date?
    let secondRoundOfInterview: Date?
    let fullTextOffer: String?
    var jobOfferRejected = false
}

