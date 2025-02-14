import SwiftUI

/// A view that displays a single photo in the queue with management options
struct PhotoItemView: View {
    let photo: PhotoItem
    let onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Three-dot menu
            Menu {
                Button("Move Left", action: { /* TODO: Implement reordering */ })
                Button("Move Right", action: { /* TODO: Implement reordering */ })
                Button("Delete", role: .destructive, action: onDelete)
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .foregroundColor(.white)
                    .padding(4)
            }
        }
    }
}
