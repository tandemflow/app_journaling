import SwiftUI

/// A view that displays a single photo in the queue with management options
struct PhotoItemView: View {
    let photo: PhotoItem
    let onDelete: () -> Void
    @State private var isDragging = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: isDragging ? 10 : 0)
                .scaleEffect(isDragging ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isDragging)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            withAnimation {
                                isDragging = true
                            }
                        }
                        .onEnded { _ in
                            withAnimation {
                                isDragging = false
                            }
                        }
                )
            
            Menu {
                Button("Delete", role: .destructive, action: onDelete)
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .foregroundColor(.white)
                    .padding(4)
            }
        }
    }
}
