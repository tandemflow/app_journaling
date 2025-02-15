import SwiftUI

/// A view that manages photo selection and queue management
struct PhotoSelectionView: View {
    @ObservedObject var viewModel: PhotoSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                // Photo Queue
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.selectedPhotos) { photo in
                            PhotoItemView(photo: photo) {
                                viewModel.removePhoto(photo)
                            }
                        }
                        
                        AddMoreButton(action: viewModel.showImagePicker)
                    }
                    .padding()
                }
                
                // Photo Count Indicator
                Text("\(viewModel.selectedPhotos.count) Photos Selected")
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    viewModel.clearSelection()
                    dismiss()
                },
                trailing: Button("Convert") {
                    viewModel.processPhotos()
                }
                .disabled(viewModel.selectedPhotos.isEmpty)
            )
        }
        .photosPicker(
            isPresented: $viewModel.showingImagePicker,
            selection: $viewModel.selectedItems,
            matching: .images,
            photoLibrary: .shared()
        )
        .sheet(isPresented: $viewModel.showingCamera) {
            CameraImagePicker(selectedImage: Binding(
                get: { nil },
                set: { image in
                    if let image = image {
                        viewModel.addPhoto(image)
                    }
                }
            ))
        }
    }
}
