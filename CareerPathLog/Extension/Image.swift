import SwiftUI

extension Image {
    static let status = StatusSymbol()
    static let menu = MenuButtonSymbol()
    static let flags = FlagsSymbol()
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
    let edit = Image(systemName: "square.and.pencil")
    let web = Image(systemName: "globe")
    let notes = Image(systemName: "note.text")
    let document = Image(systemName: "doc.plaintext")
}

struct FlagsSymbol {
    let czech = Image("czech-republic")
    let english = Image("united-kingdom")
}
