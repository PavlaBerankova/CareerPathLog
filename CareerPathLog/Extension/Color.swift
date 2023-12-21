import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let warm = WarmTheme1()
    static let gray = GrayTheme()
    static let test = TestTheme()
}

struct ColorTheme {
    let mainColor = Color("Warm1")
    let deniedColor = Color("Orange")
    let whiteColor = Color.white
    let blackColor = Color.black
    let link = Color("BlueLink")
    let blueText = Color("BlueText")
}

struct WarmTheme1 {
    let first = Color("Warm1")
    let second = Color("Warm2")
    let third = Color("Warm3")
    let four = Color("Warm4")
}

struct GrayTheme {
    let first = Color("Gray1")
    let second = Color("Gray2")
    let third = Color("Gray3")
    let four = Color("Gray4")
}

struct TestTheme {
    let first = Color("1")
    let second = Color("2")
    let third = Color("3")
}
