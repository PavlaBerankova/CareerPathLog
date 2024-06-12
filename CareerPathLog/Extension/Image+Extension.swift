import SwiftUI

extension Image {
    static let menu = MenuButtonSymbol()
    static let flags = FlagsSymbol()
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
