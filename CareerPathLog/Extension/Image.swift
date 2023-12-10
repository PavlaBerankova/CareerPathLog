import SwiftUI

extension Image {
    static let status = StatusSymbol()
}

struct StatusSymbol {
    let rejected = Image(systemName: "x.square")
    let rejected2 = Image(systemName: "exclamationmark.bubble")
    let accepted = Image(systemName: "checkmark.bubble")
    let interview = Image(systemName: "person.bubble.fill")
    let sending = Image(systemName: "envelope")
    let noResponse = Image(systemName: "clock.arrow.circlepath")
}
