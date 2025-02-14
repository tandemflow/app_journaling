import SwiftUI

/// Manages the state and business logic for photo selection
class PhotoSelectionViewModel: ObservableObject {
    @Published var selectedPhotos: [PhotoItem] = []
    @Published var showingImagePicker = false
    @Published var currentImage: UIImage? {
        didSet {
            if let image = currentImage {
                addPhoto(image)
                currentImage = nil
            }
        }
    }
    
    /// Shows the image picker
    func showImagePicker() {
        showingImagePicker = true
    }
    
    /// Adds a photo to the queue
    /// - Parameter image: The UIImage to add
    private func addPhoto(_ image: UIImage) {
        let newPhoto = PhotoItem(image: image)
        selectedPhotos.append(newPhoto)
    }
    
    /// Removes a photo from the queue
    /// - Parameter photo: The photo to remove
    func removePhoto(_ photo: PhotoItem) {
        selectedPhotos.removeAll { $0.id == photo.id }
    }
    
    /// Clears all selected photos
    func clearSelection() {
        selectedPhotos.removeAll()
    }
    
    /// Processes the selected photos for OCR
    func processPhotos() {
        // TODO: Implement OCR processing
        // This will be implemented when we integrate with OCRManager
    }
}
