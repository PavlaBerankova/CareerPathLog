import SwiftUI

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
            "Open URL"
        case .notes:
            "Show notes"
        case .fullText:
            "Show fulltext offer"
        }
    }
}
