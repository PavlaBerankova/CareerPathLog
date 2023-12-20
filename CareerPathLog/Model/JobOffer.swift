import Foundation
import SwiftUI

struct JobOffer: Codable, Identifiable, Equatable {
    static func == (lhs: JobOffer, rhs: JobOffer) -> Bool {
            return lhs.id == rhs.id
        }

    var id = UUID()
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let salary: String?
    let notes: String?
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
    var numberOfDaysSinceSendCV: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: dateOfSentCV, to: Date.now)
        return abs(components.day!)
    }
    var statusText: String {
        if reply {
            switch status {
            case .noResponse:
                return "\(numberOfDaysSinceSendCV.inflectWordDay()) \(Status.noResponse.rawValue)"
            case .interview:
                return Status.interview.rawValue
            case .rejected:
                return Status.rejected.rawValue
            case .accepted:
                return Status.accepted.rawValue
            case .allStatus:
                return Status.allStatus.rawValue
            }
        } else {
            return "\(numberOfDaysSinceSendCV.inflectWordDay()) \(Status.noResponse.rawValue)"
        }
    }
    var statusSubtitle: String? {
        if reply && status == .interview {
                if firstRoundInterview && secondRoundInterview && thirdRoundInterview {
                    return "3. kolo"
                } else if firstRoundInterview && secondRoundInterview {
                    return "2. kolo"
                } else if firstRoundInterview {
                    return "1. kolo"
                }
            }
            return nil
    }
}

enum Status: String, Codable, CaseIterable {
    case allStatus = "vše"
    case noResponse = "bez odpovědi"
    case interview = "pozvání na pohovor"
    case accepted = "pracovní nabídka"
    case rejected = "zamítnuto"
}
