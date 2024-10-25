import SwiftUI

struct CustomTextFieldView: View {
    
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(height: 60)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.systemPrimaryColor, lineWidth: 1)
            )
            .padding()
    }
}
