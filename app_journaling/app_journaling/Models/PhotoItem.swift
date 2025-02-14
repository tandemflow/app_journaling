import SwiftUI

/// Represents a photo in the selection queue
struct PhotoItem: Identifiable {
    let id = UUID()
    let image: UIImage
    var order: Int?
}
