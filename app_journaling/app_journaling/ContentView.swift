//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/14/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var showingMediaOptions = false
    @StateObject private var viewModel = PhotoSelectionViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if !viewModel.selectedPhotos.isEmpty {
                    PhotoSelectionView(viewModel: viewModel)
                }
                
                Spacer()
                
                Button(action: {
                    showingMediaOptions = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.bottom, 30)
            }
            .confirmationDialog("Add Photo", isPresented: Binding(
                get: { viewModel.showingMediaOptions },
                set: { @MainActor newValue in
                    viewModel.showingMediaOptions = newValue
                }
            )) {
                Button("Choose from Library") {
                    viewModel.showingImagePicker = true
                }
                Button("Take Photo") {
                    viewModel.showingCamera = true
                }
            }
            .photosPicker(
                    isPresented: Binding(
                        get: { viewModel.showingImagePicker },
                        set: { @MainActor newValue in
                            viewModel.showingImagePicker = newValue
                        }
                    ),
                    selection: Binding(
                        get: { viewModel.selectedItems },
                        set: { @MainActor newValue in
                            viewModel.selectedItems = newValue
                        }
                    ),
                    matching: .images,
                    photoLibrary: .shared()
                )
                .cameraPicker(
                    isPresented: Binding(
                        get: { viewModel.showingCamera },
                        set: { @MainActor newValue in
                            viewModel.showingCamera = newValue
                        }
                    ),
                    selection: Binding(
                        get: { viewModel.capturedImage },
                        set: { @MainActor newValue in
                            viewModel.capturedImage = newValue
                        }
                    )
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
