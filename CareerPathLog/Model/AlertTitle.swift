import SwiftUI

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
            "Note is missing"
        case .fulltext:
            "Text offer is missing"
        }
    }
}
