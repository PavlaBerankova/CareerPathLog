import SwiftUI

extension Image {
    static let status = StatusSymbol()
    static let info = MenuButtonSymbol()
}

struct StatusSymbol {
    let allSendCv = Image(systemName: "envelope")
    let noResponse = Image(systemName: "clock.arrow.circlepath")
    let interview = Image(systemName: "person.bubble")
    let accepted = Image(systemName: "checkmark.bubble")
    let rejected = Image(systemName: "x.square")
}

struct MenuButtonSymbol {
    let menuDots = Image(systemName: "ellipsis")
    let edit = "square.and.pencil"
    let web = "globe"
    let notes = "note.text"
    let document = "doc.plaintext"
}
