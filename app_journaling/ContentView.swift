//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/5/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
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
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    
    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer() // Pushes content to top
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text("Hello, world!")
                    .foregroundColor(.white)
                
                Spacer() // Creates space before button
                
                Button(action: {
                    showCamera = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.gray))
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $showCamera) {
                    ImagePicker(selectedImage: $capturedImage)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
