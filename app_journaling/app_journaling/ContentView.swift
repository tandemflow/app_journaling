//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/14/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoSelectionViewModel()
    @State private var showingMediaOptions = false
    @State private var showingPhotoPicker = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showingPhotoSelection = false
    
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
                .confirmationDialog("Add Photo", isPresented: $showingMediaOptions) {
                    Button("Choose from Library") {
                        showingPhotoPicker = true
                    }
                    Button("Take Photo") {
                        // Camera will be implemented later
                    }
                }
                .photosPicker(isPresented: $showingPhotoPicker,
                            selection: $selectedItems,
                            matching: .images,
                            photoLibrary: .shared())
            }
            .onChange(of: selectedItems) { oldItems, newItems in
                Task {
                    for item in newItems {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            await MainActor.run {
                                viewModel.addPhoto(image)
                                showingPhotoSelection = true
                            }
                        }
                    }
                    selectedItems = []
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
