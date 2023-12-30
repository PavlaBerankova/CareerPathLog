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
    var statusText: LocalizedStringResource {
        if response {
            switch status {
            case .noResponse:
                return "\(numberOfDaysSinceSubmittedCV) dní bez odpovědi"
            case .interview:
                return Status.interview.title
            case .rejected:
                return Status.rejected.title
            case .accepted:
                return Status.accepted.title
            case .allStatus:
                return Status.allStatus.title
            }
        } else {
            return "\(numberOfDaysSinceSubmittedCV) dní bez odpovědi"
        }
    }
    var statusSubtitle: LocalizedStringResource? {
        if response && status == .interview {
                if firstRoundOfInterview && secondRoundOfInterview && thirdRoundOfInterview {
                    return "3. kolo"
                } else if firstRoundOfInterview && secondRoundOfInterview {
                    return "2. kolo"
                } else if firstRoundOfInterview {
                    return "1. kolo"
                }
            }
            return nil
    }
}

enum Status: Identifiable, CaseIterable, Codable {
    case allStatus
    case noResponse
    case interview
    case accepted
    case rejected

    var id: Self { return self }

    var title: LocalizedStringResource {
        switch self {
        case .allStatus:
            "vše"
        case .noResponse:
            "bez odpovědi"
        case .interview:
            "pozvání na pohovor"
        case .accepted:
            "pracovní nabídka"
        case .rejected:
            "zamítnuto"
        }
    }

    var titleBySelectedFilter: LocalizedStringKey {
        switch self {
        case .allStatus:
            "All submitted CV"
            // "Oslovené firmy"
        case .noResponse:
            "No response"
            // "CV bez odpovědi"
        case .interview:
            "Interview"
            // "Pozvání na pohovor"
        case .accepted:
            "Accepted"
            // "Pracovní nabídky"
        case .rejected:
            "Rejected"
            // "Zamítnuté"
        }
    }
}

enum MenuItemRow: Identifiable, Codable {
    case edit
    case url
    case notes
    case fullText

    var id: Self { return self }

    var title: LocalizedStringKey {
        switch self {
        case .edit:
            "Edit"
        case .url:
            "Open url"
        case .notes:
            "Show notes"
        case .fullText:
            "Show fulltext offer"
        }
    }
}

enum AlertTitle: Identifiable, Codable {
    case url
    case notes
    case fulltext

    var id: Self { return self }

    var title: LocalizedStringKey {
        switch self {
        case .url:
            "URL offer is missing"
        case .notes:
            "Notes are missing"
        case .fulltext:
            "Text offer is missing"
        }
    }
}
