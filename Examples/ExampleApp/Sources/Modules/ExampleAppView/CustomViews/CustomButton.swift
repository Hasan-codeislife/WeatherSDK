import SwiftUI

struct CustomButton: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.systemPrimaryColor)
                .cornerRadius(25)
               
        }
        .padding(.horizontal, 20)
    }
}
