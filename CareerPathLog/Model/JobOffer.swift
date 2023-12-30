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
    let dateOfSubmissionV: Date
    var response: Bool
    let dateOfResponse: Date?
    var firstRoundOfInterview: Bool
    let dateOfFirstRoundOfInterview: Date?
    var secondRoundOfInterview: Bool
    let dateOfSecondRoundOfInterview: Date?
    var thirdRoundOfInterview: Bool
    let dateOfThirdRoundOfInterview: Date?
    let fullTextOffer: String?
    var status: Status = .noResponse
    var numberOfDaysSinceSubmittedCV: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: dateOfSubmissionV, to: Date.now)
        return abs(components.day!)
    }
    var statusText: LocalizedStringKey {
        if response {
            switch status {
            case .noResponse:
                return "\(numberOfDaysSinceSubmittedCV) days without response"
            case .interview:
                return "interview"
            case .rejected:
                return "rejected"
            case .accepted:
                return "accepted"
            case .allStatus:
                return "all submitted CV"
            }
        } else {
            return "\(numberOfDaysSinceSubmittedCV) days without response"
        }
    }
    var statusSubtitle: LocalizedStringResource? {
        if response && status == .interview {
                if firstRoundOfInterview && secondRoundOfInterview && thirdRoundOfInterview {
                    return "3. round"
                } else if firstRoundOfInterview && secondRoundOfInterview {
                    return "2. round"
                } else if firstRoundOfInterview {
                    return "1. round"
                }
            }
            return nil
    }
}
