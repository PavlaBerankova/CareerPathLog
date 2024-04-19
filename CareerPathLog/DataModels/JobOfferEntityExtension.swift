import CoreData
import SwiftUI

//class DataManager {
//  static let shared = DataManager()
//
//  let context: NSManagedObjectContext
//
//  private init() {
//    // inicializace persistentního kontextu nebo jiný způsob získání kontextu
//    context = NSPersistentContainer(name: "JobOfferDataModel").viewContext
//  }
//}


extension JobOfferEntity {
    convenience init(
        companyName: String,
        jobTitle: String,
        offerUrl: String,
        salary: String,
        notes: String,
        dateOfSentCv: Date,
        response: Bool,
        dateOfResponse: Date?,
        firstRoundOfInterview: Bool,
        dateOfFirstRoundOfInterview: Date?,
        secondRoundOfInterview: Bool,
        dateOfSecondRoundOfInterview: Date?,
        thirdRoundOfInterview: Bool,
        dateOfThirdRoundOfInterview: Date?,
        fullTextOffer: String?,
        status: String?,
        jobLocation: String?) {
            self.init(context: PersistenceController.shared.container.viewContext)
            self.companyName = companyName
            self.jobTitle = jobTitle
            self.offerUrl = offerUrl
            self.salary = salary
            self.notes = notes
            self.dateOfSentCv = dateOfSentCv
            self.response = response
            self.dateOfResponse = dateOfResponse
            self.firstRoundOfInterview = firstRoundOfInterview
            self.dateOfFirstRoundOfInterview = dateOfFirstRoundOfInterview
            self.secondRoundOfInterview = secondRoundOfInterview
            self.dateOfSecondRoundOfInterview = dateOfSecondRoundOfInterview
            self.thirdRoundOfInterview = thirdRoundOfInterview
            self.dateOfThirdRoundOfInterview = dateOfThirdRoundOfInterview
            self.fullTextOffer = fullTextOffer
            self.status = status
            self.jobLocation = jobLocation
        }

    var viewCompanyName: String {
        companyName ?? ""
    }

    var viewJobTitle: String {
        jobTitle ?? ""
    }

    var viewOfferUrl: String {
        offerUrl ?? ""
    }

    var viewSalary: String {
        salary ?? ""
    }

    var viewNotes: String {
        notes ?? ""
    }

    var viewDateOfSentCv: String {
        dateOfSentCv?.formattedDate() ?? ""
    }

    var viewDateOfResponse: String {
        dateOfResponse?.formattedDate() ?? ""
    }

    var viewDateOfFirstRoundOfInterview: Date {
        dateOfFirstRoundOfInterview ?? Date()
    }

    var viewDateOfSecondRoundOfInterview: Date {
        dateOfSecondRoundOfInterview ?? Date()
    }

    var viewDateOfThirdRoundOfInterview: Date {
        dateOfThirdRoundOfInterview ?? Date()
    }

    var viewFullTextOffer: String {
        fullTextOffer ?? ""
    }

    //    var viewStatus: String {
    //        status ?? "No response"
    //    }

    var viewStatus: Status {
        get {
            return Status(rawValue: String(self.status ?? "No response")) ?? .noResponse
        }
        set {
            self.status = String(newValue.rawValue)
        }
    }

    var viewNumberOfDaysSinceSubmittedCv: Int {
        let calendar = Calendar.current
        let componenets = calendar.dateComponents([.day], from: dateOfSentCv ?? Date(), to: Date.now)
        return abs(componenets.day!)
    }

    var viewStatusText: LocalizedStringKey {
        if response {
            switch viewStatus {
            case .noResponse:
                return "\(viewNumberOfDaysSinceSubmittedCv) days without response"
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
            return "\(viewNumberOfDaysSinceSubmittedCv) days without response"
        }
    }

    var viewInterviewStatusSubtitle: LocalizedStringResource? {
        if response && viewStatus == .interview {
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

    var viewJobLocation: String {
        jobLocation ?? ""
    }
}
