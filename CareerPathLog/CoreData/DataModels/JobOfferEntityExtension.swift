import CoreData
import SwiftUI

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
        jobLocation: String?,
        jobLevel: String?,
        typesOfEmployment: String?,
        workingArrangements: String?,
        isArchived: Bool = false
    ) {
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
            self.jobLevel = jobLevel
            self.typesOfEmployment = typesOfEmployment
            self.workingArrangements = workingArrangements
            self.isArchived = isArchived
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
            case .interview:
                return "interview"
            case .rejected:
                return "rejected"
            case .accepted:
                return "accepted"
            case .allStatus:
                return "all submitted CV"
            default: return  "\(viewNumberOfDaysSinceSubmittedCv) days without response"
            }
        } else {
            return "\(viewNumberOfDaysSinceSubmittedCv) days without response"
        }
    }

    var viewStatusSubtitle: LocalizedStringResource? {
        if response && viewStatus == .interview {
            if firstRoundOfInterview && secondRoundOfInterview && thirdRoundOfInterview {
                return "3. round"
            } else if firstRoundOfInterview && secondRoundOfInterview {
                return "2. round"
            } else if firstRoundOfInterview {
                return "1. round"
            }
        } else if isArchived {
            return "archived"
        }
        return nil
    }

    var viewJobLocation: String {
        jobLocation ?? ""
    }

    var viewJobLevel: JobLevel {
        get {
            return JobLevel(rawValue: String(self.jobLevel ?? "none")) ?? .none
        }
        set {
            self.jobLevel = String(newValue.rawValue)
        }
    }

    var viewTypesOfEmployment: TypesOfEmployment {
        get {
            return TypesOfEmployment(rawValue: String(self.typesOfEmployment ?? "none")) ?? .none
        }
        set {
            self.typesOfEmployment = String(newValue.rawValue)
        }
    }

    var viewWorkingArrangements: WorkingArrangements {
        get {
            return WorkingArrangements(rawValue: String(self.workingArrangements ?? "none")) ?? .none
        }
        set {
            self.workingArrangements = String(newValue.rawValue)
        }
    }
}
