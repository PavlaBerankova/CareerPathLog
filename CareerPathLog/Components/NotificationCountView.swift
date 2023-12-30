import SwiftUI

struct NotificationCountView : View {
    // MARK: - PROPERTIES
    var value: Int
    var foreground: Color  {
        if status == .allStatus {
            return Color.white
        } else {
            return Color.black
        }
    }
    var background: Color {
        switch status {
        case .allStatus:
            return Color("DarkGrayColor")
        case .noResponse:
            return Color("BlueColor")
        case .interview:
            return Color.yellow
        case .rejected:
            return Color.red
        case .accepted:
            return Color.green
        }
    }

    let status: Status

    private let size = 16.0
    private let x = 50.0
    private let y = 15.0

    // MARK: - BODY
    var body: some View {
        ZStack {
            Capsule()
                .fill(background)
                .frame(width: size * widthMultplier(), height: size, alignment: .topTrailing)
                .position(x: x, y: y)

            if hasTwoOrLessDigits() {
                Text("\(value)")
                    .foregroundColor(foreground)
                    .font(Font.caption)
                    .position(x: x, y: y)
            } else {
                Text("99+")
                    .foregroundColor(foreground)
                    .font(Font.caption)
                    .frame(width: size * widthMultplier(), height: size, alignment: .center)
                    .position(x: x, y: y)
            }
        }
    }

    // showing more than 99 might take too much space, rather display something like 99+
    func hasTwoOrLessDigits() -> Bool {
        return value < 100
    }

    func widthMultplier() -> Double {
        if value < 10 {
            // one digit
            return 1.0
        } else if value < 100 {
            // two digits
            return 1.5
        } else {
            // too many digits, showing 99+
            return 2.0
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack(spacing: 20) {
        NotificationCountView(value: 10, status: .allStatus)
        NotificationCountView(value: 5, status: .noResponse)
        NotificationCountView(value: 3, status: .interview)
        NotificationCountView(value: 0, status: .accepted)
        NotificationCountView(value: 4, status: .rejected)
    }
    .fixedSize()
}
