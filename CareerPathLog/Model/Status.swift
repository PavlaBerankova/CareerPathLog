import SwiftUI

enum Status: Identifiable, CaseIterable, Codable {
    case allStatus
    case noResponse
    case interview
    case accepted
    case rejected

    var id: Self { return self }

    var title: LocalizedStringKey {
        switch self {
        case .allStatus:
            "All submitted CV"
        case .noResponse:
            "No response"
        case .interview:
            "Interview"
        case .accepted:
            "Accepted"
        case .rejected:
            "Rejected"
        }
    }
}
