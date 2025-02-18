import SwiftUI

/// Represents a photo in the selection queue
struct PhotoItem: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
    var order: Int?
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.id == rhs.id
    }
}
