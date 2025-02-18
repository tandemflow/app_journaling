import SwiftUI
import PhotosUI

/// Manages the state and business logic for photo selection
class PhotoSelectionViewModel: ObservableObject {
    @Published var selectedPhotos: [PhotoItem] = []
    @Published var showingMediaOptions = false
    @Published var showingImagePicker = false
    @Published var showingCamera = false
    @Published var capturedImage: UIImage? {
        didSet {
            if let image = capturedImage {
                Task { @MainActor in
                    addPhoto(image)
                    capturedImage = nil
                    showingCamera = false
                }
            }
        }
    }
    @Published var selectedItems: [PhotosPickerItem] = [] {
        didSet {
            Task { @MainActor in
                for item in selectedItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        addPhoto(image)
                    }
                }
                selectedItems = []
            }
        }
    }
    
    /// Shows the image picker
    func showImagePicker() {
        showingImagePicker = true
    }
    
    /// Shows the camera
    func showCamera() {
        showingCamera = true
    }
    
    /// Adds a photo to the queue
    /// - Parameter image: The UIImage to add
    public func addPhoto(_ image: UIImage) {
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
