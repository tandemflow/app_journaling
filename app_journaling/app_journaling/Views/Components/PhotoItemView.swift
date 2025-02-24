import SwiftUI

/// A view that displays a single photo in the queue with management options
struct PhotoItemView: View {
    let photo: PhotoItem
    let onDelete: () -> Void
    @ObservedObject var viewModel: PhotoSelectionViewModel
    @State private var isDragging = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: isDragging ? 15 : 0, x: 0, y: isDragging ? 8 : 0)
                .scaleEffect(isDragging ? 1.08 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isDragging)
            
            // Remove menu since delete is now handled by trash button
        }
        .onDrag {
            isDragging = true
            viewModel.draggingPhotoId = photo.id.uuidString
            return NSItemProvider(object: photo.id.uuidString as NSString)
        }
        .opacity(isDragging ? 0.7 : 1.0)
        .onDisappear {
            isDragging = false
        }
        .onChange(of: photo.order) { oldValue, newValue in
            isDragging = false
        }
    }
}

struct DropViewDelegate: DropDelegate {
    let items: [PhotoItem]
    let moveAction: (IndexSet, Int) -> Void
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedItem = info.itemProviders(for: [.text]).first,
              let fromIndex = items.firstIndex(where: { $0.id.uuidString == draggedItem.registeredTypeIdentifiers.first }) else {
            return
        }
        
        _ = info.location
        let toIndex = items.count - 1
        
        if fromIndex != toIndex {
            moveAction(IndexSet(integer: fromIndex), toIndex)
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
