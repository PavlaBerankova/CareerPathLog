import SwiftUI

struct GlassEfectBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [.white, .white.opacity(0.0)]), startPoint: .top, endPoint: .bottom)

            LinearGradient(gradient:
                            Gradient(colors: [Color.purple.opacity(0.2), .cyan.opacity(0.4)]), startPoint: .top, endPoint: .bottomTrailing)

            Color.white.opacity(0.35)
        }
    }
}

#Preview {
    GlassEfectBackgroundView()
}
