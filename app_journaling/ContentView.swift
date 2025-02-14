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
    
    // Add configuration options
    var allowsEditing: Bool = false
    var cameraDevice: UIImagePickerController.CameraDevice = .rear
    var cameraCaptureMode: UIImagePickerController.CameraCaptureMode = .photo
    var cameraFlashMode: UIImagePickerController.CameraFlashMode = .auto
    var imageExportPreset: UIImagePickerController.ImageURLExportPreset = .compatible
    var videoQuality: UIImagePickerController.QualityType = .typeMedium
    var videoMaximumDuration: TimeInterval = 600 // 10 minutes default
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = allowsEditing
        
        if sourceType == .camera {
            // Check camera availability and set fallback
            if UIImagePickerController.isCameraDeviceAvailable(cameraDevice) {
                picker.cameraDevice = cameraDevice
            } else if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                picker.cameraDevice = .rear
            } else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                picker.cameraDevice = .front
            }
            
            // Basic camera configuration
            picker.cameraCaptureMode = cameraCaptureMode
            picker.cameraFlashMode = cameraFlashMode
            picker.modalPresentationStyle = .fullScreen
            
            // Video specific settings if needed
            if cameraCaptureMode == .video {
                picker.videoQuality = videoQuality
                picker.videoMaximumDuration = videoMaximumDuration
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
            if parent.allowsEditing {
                if let editedImage = info[.editedImage] as? UIImage {
                    parent.image = editedImage
                }
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.image = originalImage
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
                       sourceType: sourceType,
                       allowsEditing: true,
                       cameraDevice: .rear,
                       cameraCaptureMode: .photo,
                       cameraFlashMode: .auto,
                       videoQuality: .typeHigh)
        }
    }
}

#Preview {
    ContentView()
}
