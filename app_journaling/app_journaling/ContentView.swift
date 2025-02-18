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
                    // Button padding ends here
                .confirmationDialog("Add Photo", isPresented: $showingMediaOptions) {
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
    }
}

#Preview {
    ContentView()
}
