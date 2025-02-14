//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/12/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        
        // Configure camera settings
        if sourceType == .camera {
            picker.modalPresentationStyle = .fullScreen
            picker.cameraCaptureMode = .photo
            
            // Let system choose available camera
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                picker.cameraDevice = .rear
            }
            
            // Only set flash mode if device has flash
            if UIImagePickerController.isFlashAvailable(for: .rear) {
                picker.cameraFlashMode = .auto
            }
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var showingSourceMenu = false
    @State private var capturedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        ZStack {
            // Keep existing dark background
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .ignoresSafeArea()
            
            VStack {
                Spacer() // Add spacer to push content to center
                
                // Center content
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
                
                Spacer() // Add spacer to maintain center position
                
                // Add plus button
                Button(action: {
                    showingSourceMenu = true
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.bottom, 20) // Add space from bottom
            }
        }
        .confirmationDialog("Choose Image Source", 
                          isPresented: $showingSourceMenu) {
            Button("Take Photo") {
                sourceType = .camera
                showingImagePicker = true
            }
            Button("Choose from Library") {
                sourceType = .photoLibrary
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(isShown: $showingImagePicker, 
                       image: $capturedImage,
                       sourceType: sourceType)
        }
    }
}

#Preview {
    ContentView()
}
