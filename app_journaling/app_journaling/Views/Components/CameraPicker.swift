import SwiftUI
import UIKit

struct CameraPicker: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selection: UIImage?
    
    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            ImagePicker(sourceType: .camera, selectedImage: $selection)
        }
    }
}

extension View {
    func cameraPicker(
        isPresented: Binding<Bool>,
        selection: Binding<UIImage?>
    ) -> some View {
        modifier(CameraPicker(isPresented: isPresented, selection: selection))
    }
}
