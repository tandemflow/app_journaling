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
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var imageDataArray: [ImageData] = []
    
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
                .confirmationDialog("Add Photo", isPresented: $showingMediaOptions) {
                    PhotosPicker(selection: $selectedItems,
                               matching: .images,
                               photoLibrary: .shared()) {
                        Text("Choose from Library")
                    }
                    Button("Take Photo") {
                        // Camera will be implemented later
                    }
                }
                .onChange(of: selectedItems) { oldItems, newItems in
                    Task {
                        for item in newItems {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                let imageData = ImageData(image: image)
                                imageDataArray.append(imageData)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
