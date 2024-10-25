import SwiftUI

struct CustomTextView: View {
    enum TextStyle {
        case title, body, bodyBold, light
    }
    
    var text: String
    var style: TextStyle = .body
    var color: Color = .primary
    var alignment: TextAlignment = .leading
    
    var body: some View {
        Text(text)
            .font(font(for: style))
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .fontWeight(fontWeight(for: style))
    }
    
    // Helper method to set the font based on the style
    private func font(for style: TextStyle) -> Font {
        switch style {
        case .title:
            return .system(size: 28, weight: .bold, design: .default)
        case .body:
            return .system(size: 16, weight: .regular, design: .default)
        case .bodyBold:
            return .system(size: 16, weight: .bold, design: .default)
        case .light:
            return .system(size: 12, weight: .light, design: .default)
        
        }
    }
    
    private func fontWeight(for style: TextStyle) -> Font.Weight {
        switch style {
        case .title, .bodyBold:
            return .bold
        case .body:
            return .regular
        case .light:
            return .light
        }
    }
}
