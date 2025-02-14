import SwiftUI

/// A button that allows users to add more photos to the queue
struct AddMoreButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30))
                Text("Add More")
                    .font(.caption)
            }
            .frame(width: 120, height: 160)
            .background(Color.secondary.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
