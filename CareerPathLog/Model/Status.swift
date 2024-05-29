import SwiftUI

enum Status: String, Identifiable, CaseIterable, Codable {
    case allStatus = ""
    case noResponse = "No response"
    case interview = "Interview"
    case accepted = "Accepted"
    case rejected = "Rejected"
    case archive = "Archive"

    var id: Self { return self }

    var title: LocalizedStringKey {
        switch self {
        case .allStatus: "All"
        case .noResponse: "No response"
        case .interview: "Interview"
        case .accepted: "Accepted"
        case .rejected: "Rejected"
        case .archive: "Archive"
        }
    }
}
