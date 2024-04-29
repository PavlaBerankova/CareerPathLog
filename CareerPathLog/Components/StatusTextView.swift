
import SwiftUI

struct StatusTextView: View {
    // MARK: - PROPERTIES
    let title: String
    let subtitle: LocalizedStringResource?
    let textColor: Color
    let backgroundColor: Color
    let borderColor: Color

    // MARK: - BODY
    var body: some View {
        Text(title)
        //                if let subtitle = subtitle {
        //                    Text(subtitle)
        //
        //
        //                }

            .font(.footnote)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
        // .background(Color.white.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(borderColor, lineWidth: 2)
            )
            .foregroundColor(textColor)
            .bold()
            .cornerRadius(8)

    }
}

// MARK: - PREVIEW
#Preview {
    ZStack {
        LinearGradient(gradient:
                        Gradient(colors: [.white, .white.opacity(0.0)]), startPoint: .top, endPoint: .bottom)

        LinearGradient(gradient:
                        Gradient(colors: [Color.purple.opacity(0.2), .cyan.opacity(0.4)]), startPoint: .top, endPoint: .bottomTrailing)

        Color.white.opacity(0.35)

        HStack(spacing: 0) {
            StatusTextView(title: "Pohovor", subtitle: "1. kolo", textColor: .black, backgroundColor: .white, borderColor: .blue)
            Rectangle()
                .frame(width: 10, height: 2)
                .foregroundColor(.blue)
            StatusTextView(title: "1.", subtitle: nil, textColor: .black, backgroundColor: .white, borderColor: .blue)
            Rectangle()
                .frame(width: 10, height: 2)
                .foregroundColor(.blue)
            StatusTextView(title: "2. kolo", subtitle: nil, textColor: .black, backgroundColor: .white, borderColor: .blue)
        }
    }
    .frame(width: 400, height: 100)
}

