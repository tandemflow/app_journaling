import SwiftUI

/// A view that manages photo selection and queue management
struct PhotoSelectionView: View {
    @ObservedObject var viewModel: PhotoSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingMediaOptions = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Photo Queue
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.selectedPhotos) { photo in
                            PhotoItemView(photo: photo, onDelete: {
                                viewModel.removePhoto(photo)
                            }, viewModel: viewModel)
                        }
                        .onMove(perform: viewModel.movePhoto)
                        .onDrop(of: [.text], delegate: DropViewDelegate(items: viewModel.selectedPhotos, moveAction: viewModel.movePhoto))
                        
                        AddMoreButton(action: {
                            viewModel.showingMediaOptions = true
                        })
                    }
                    .padding()
                }
                
                Spacer()
                
                VStack(spacing: 8) {
                    // Photo Count Indicator
                    Text("\(viewModel.selectedPhotos.count) Photos Selected")
                        .foregroundColor(.secondary)
                    
                    // Show Trash button only when photos are present
                    if !viewModel.selectedPhotos.isEmpty {
                        TrashButton(
                            action: {
                                if let draggingId = viewModel.draggingPhotoId,
                                   let photo = viewModel.selectedPhotos.first(where: { $0.id.uuidString == draggingId }) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        viewModel.removePhoto(photo)
                                    }
                                }
                            },
                            isTargeted: $viewModel.isOverTrash
                        )
                    }
                }
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
        .confirmationDialog("Add Photo", isPresented: $viewModel.showingMediaOptions) {
            Button("Choose from Library") {
                viewModel.showingImagePicker = true
            }
            Button("Take Photo") {
                viewModel.showingCamera = true
            }
        }
        .photosPicker(
            isPresented: $viewModel.showingImagePicker,
            selection: $viewModel.selectedItems,
            matching: .images,
            photoLibrary: .shared()
        )
        .cameraPicker(
            isPresented: $viewModel.showingCamera,
            selection: $viewModel.capturedImage
        )
    }
}
