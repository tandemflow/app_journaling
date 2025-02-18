import SwiftUI

/// A button that displays a trash can icon for deleting photos
struct TrashButton: View {
    let action: () -> Void
    @Binding var isTargeted: Bool
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isTargeted ? "trash.circle.fill" : "trash.circle")
                .font(.system(size: 30))
                .foregroundColor(isTargeted ? .red : .gray)
                .frame(width: 120, height: 160)
                .background(Color.secondary.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
