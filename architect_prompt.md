# Architect Prompt Template
Process this file working through each step to ensure each objective is met.

## High Level Goals

# AI Coding Assistant Development Plan: OCR & LLM-Powered iOS App

## 1. High-Level Overview

### Objective
Develop an iOS application that allows users to:
- Capture or upload images for Optical Character Recognition (OCR).
- Process extracted text using an LLM (e.g., Ollama).
- Filter, simplify, and save the output as markdown (`.md`) files.
- Provide a basic markdown text editor for modifying saved files.

### Core Functionalities
#### 1. Image Capture & Upload
- Camera access for taking images.
- File picker for selecting images from the device.

#### 2. OCR Processing
- Extract text using Apple’s **Vision framework** or a third-party OCR library (e.g., Tesseract).

#### 3. LLM Integration
- Send OCR-extracted text to a local or cloud-based LLM (e.g., Ollama).
- Filter and summarize the text.

#### 4. File Management
- Store outputs as `.md` files in a user-specified directory.
- Open, edit, and save markdown files within the app.

#### 5. Simple Markdown Editor
- Load, modify, and save markdown files with a minimalistic editor.

---

## 2. Mid-Level Components

### User Interface (UI) Components
- **Main Screen**
  - Buttons for image capture & upload.
  - List of saved markdown files.
- **OCR Processing Screen**
  - Image preview.
  - Extracted text display.
  - Options to process text with LLM.
- **Markdown Editor**
  - Text editor with basic markdown support.
  - Save button.

### Data Handling
- **Image Processing**: Convert images into grayscale, optimize for OCR.
- **Markdown Storage**: Use the device's file system or iCloud for storage.
- **LLM API Communication**: Send extracted text to an LLM, receive and display responses.

### Technology Stack
- **SwiftUI** for UI design.
- **Apple Vision OCR** for text extraction.
- **Ollama LLM API** (local or cloud-based) for processing extracted text.
- **FileManager API** for markdown file handling.
- **Core Data (or SQLite)** for indexing saved files.

---

## 3. Implementation Guidelines

### Important Technical Details
- **OCR Handling**: Apple’s Vision framework provides fast and efficient text detection, reducing the need for external dependencies.
- **LLM Communication**: Ollama can run locally but may require WebSockets or REST API integration for efficient text processing.
- **File Management**: Ensure proper access permissions and iCloud synchronization if needed.
- **Security Considerations**: OCR data should be processed on-device whenever possible for privacy.

### Dependencies & Requirements
1. **Apple Vision Framework** (For OCR)
2. **SwiftUI & UIKit** (For UI/UX)
3. **TesseractOCR (Optional)** for more complex OCR needs
4. **URLSession / WebSockets** (For LLM API communication)
5. **FileManager API** (For local markdown storage)
6. **Markdown Rendering Library** (e.g., Down for rendering `.md`)

### Coding Standards to Follow
- **Use MVVM (Model-View-ViewModel) Architecture** for maintainability.
- **Follow Apple’s HIG (Human Interface Guidelines)** for UI consistency.
- **Use Async/Await** for all network calls to prevent blocking UI.
- **Write Unit Tests** for OCR processing and file handling.

### Other Technical Guidance
- **Optimize OCR Accuracy**: Preprocess images (grayscale, binarization) for improved text recognition.
- **Use Local Processing Where Possible**: Keep text processing within the device when feasible to reduce API costs and latency.
- **Markdown Formatting**: Provide syntax highlighting or a preview mode for better UX.
- **Ensure Accessibility**: Support VoiceOver and Dynamic Text.

---

## Project Context

### Beginning files
- README.md
- app_journaling.xcodeproj
    - project.xcworkspace
        - xcshareddata
        - xcuserdata
            - UserInterfaceState.xcuserstate
        - contents.xcworkspacedata
    - xcuserdata
        - xcschememanagement.plist
    project.pbxproj
- app_journalingUITests
    - app_journalingUITests.swift
    - app_journalingUITestsLaunchTests.swift
- developer_guide.md
- app_journaling
    - Assets.xcassets
        - AccentColor.colorset
            - Contents.json
        - Applecon.appiconset
            - Contents.json
        - Contents.json
    - Preview Content
        - Contents.json
    - app_journing.entitlements
    - app_journalingApp.swift
    - ContentView.swift
- app_journalingTests
    - app_journalingTests.swift
- architect_prompt.md

## 4. Low-Level Goals
> Ordered from first to last

### 1. **First Task - Implement OCR Functionality**  
```code-example
What prompt would you run to complete this task?
- Implement OCR extraction using Apple's Vision framework.
What file do you want to work on?
- OCRManager.swift
What function do you want to work on?
- extractText(from image: UIImage) -> String
What are details you want to add to ensure consistency?
- Ensure proper error handling and optimize for multiple languages.
```

### 2. **Second Task - Integrate LLM Processing**  
```code-example
What prompt would you run to complete this task?
- Send extracted text to Ollama’s API and retrieve processed output.
What file do you want to work on?
- LLMProcessor.swift
What function do you want to work on?
- processText(_ text: String) -> String
What are details you want to add to ensure consistency?
- Implement async/await pattern for smooth API calls.
- Ensure proper tokenization and formatting before sending requests.
```

### 3. **Third Task - Implement Markdown File Management**  
```code-example
What prompt would you run to complete this task?
- Store and retrieve markdown files using FileManager API.
What file do you want to work on?
- MarkdownFileManager.swift
What function do you want to work on?
- saveMarkdown(content: String, filename: String)
- loadMarkdown(filename: String) -> String
What are details you want to add to ensure consistency?
- Ensure compatibility with iCloud for cloud sync.
- Implement file encryption for user privacy.
```

---

## 5. **Photo Selection Menu Guidelines**

The **Photo Selection Menu** allows users to add images either by capturing a new photo or selecting one from their library. It provides a streamlined experience for managing images before processing them with OCR.

### **1. Image Selection and Queue Management**
- Users can add images using:
  - **Take Photo** – Opens the camera to capture a new image.
  - **Choose from Library** – Opens the device's photo library.
- The selected images are displayed in a **horizontal scrollable queue** for easy navigation.
- **Image Sizing**:
  - Photos should be **large enough for recognition** but **not full-screen**, ensuring a clear, compact layout.
- The bottom of the menu displays a **photo count indicator** (e.g., *"2 Photos Selected"*) for quick reference.

### **2. Menu Options and Actions**
#### **Top Menu Bar**
- **Top Left: "Cancel"**  
  - Cancels the action and **clears all temporary selections**.
  - Resets the function so that future selections start fresh.
- **Top Right: "Convert"**  
  - Initiates **OCR processing** using Apple's Vision framework.
  - Calls functions from `OCRManager.swift`.

#### **Image Management**
- **Trash Icon (Bottom of Each Photo)**  
  - Allows users to delete specific photos from the queue.
- **Three-Dot Icon (Top of Each Photo)**  
  - Enables users to **reorder** photos in the queue.
  - Critical for ensuring the correct sequence before OCR processing.

#### **Adding More Photos**
- **"Add More" Button (Far Right of Scrollable Queue)**  
  - Styled similarly to the centered button on the home screen.
  - Opens the menu again, allowing users to select additional photos from:
    - *Take Photo*
    - *Choose from Library*
