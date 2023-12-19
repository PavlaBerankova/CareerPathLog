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
    var numberOfDaysSinceSendCV: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: dateOfSentCV, to: Date.now)
        return abs(components.day!)
    }
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
    var statusText: String {
        if reply {
            switch status {
            case .noResponse:
                return "\(declensionWordDay(numberOfDaysSinceSendCV)) bez odpovědi"
            case .interview:
                return "pozvání na pohovor"
            case .rejected:
                return "zamítnuto"
            case .accepted:
               return "pracovní nabídka"
            case .allStatus:
                return "zobrazit vše"
            }
        } else {
            return "\(declensionWordDay(numberOfDaysSinceSendCV)) \(Status.noResponse.rawValue)"
        }
    }
    var statusSubtitle: String? {
            if reply {
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
    var jobOfferRejected = false
}

extension JobOffer {
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

    func statusText(_ offer: JobOffer) -> String {
        if offer.reply {
            switch offer.status {
            case .noResponse:
                return "\(declensionWordDay(numberOfDaysSinceSendCV)) bez odpovědi"
            case .interview:
                return "pozvání na pohovor"
            case .rejected:
                return "zamítnuto"
            case .accepted:
               return "pracovní nabídka"
            case .allStatus:
                return "zobrazit vše"
            }
        } else {
            return "\(declensionWordDay(numberOfDaysSinceSendCV)) \(Status.noResponse.rawValue)"
        }
    }
}

enum Status: String, Codable, CaseIterable {
    case allStatus = "vše"
    case noResponse = "bez odpovědi"
    case interview = "pozvání na pohovor"
    case accepted = "pracovní nabídka"
    case rejected = "zamítnuto"
}
