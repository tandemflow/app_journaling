import SwiftUI
import PhotosUI

/// Manages the state and business logic for photo selection
class PhotoSelectionViewModel: ObservableObject {
    @Published var selectedPhotos: [PhotoItem] = []
    @Published var isDraggingToTrash: Bool = false
    @Published var isOverTrash: Bool = false
    @Published var draggingPhotoId: String?
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
                let newImages = try? await withThrowingTaskGroup(of: UIImage?.self) { group in
                    for item in selectedItems {
                        group.addTask {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                return image
                            }
                            return nil
                        }
                    }
                    
                    var images: [UIImage] = []
                    for try await image in group {
                        if let image = image {
                            // Check if image is already in selectedPhotos
                            let imageData = image.pngData()
                            let isDuplicate = selectedPhotos.contains { photo in
                                photo.image.pngData() == imageData
                            }
                            if !isDuplicate {
                                images.append(image)
                            }
                        }
                    }
                    return images
                }
                
                if let newImages = newImages {
                    for image in newImages {
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
    
    /// Moves a photo from one position to another
    /// - Parameters:
    ///   - fromOffsets: Source indices
    ///   - toOffset: Destination index
    func movePhoto(fromOffsets: IndexSet, toOffset: Int) {
        selectedPhotos.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        // Update order after move
        for (index, var photo) in selectedPhotos.enumerated() {
            photo.order = index
            selectedPhotos[index] = photo
        }
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
