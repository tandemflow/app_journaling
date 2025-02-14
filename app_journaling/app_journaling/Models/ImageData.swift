import UIKit

struct ImageData: Identifiable {
    let id = UUID()
    let image: UIImage
    var processedText: String? // For future OCR processing
}
