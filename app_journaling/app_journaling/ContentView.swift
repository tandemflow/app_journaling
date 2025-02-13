//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/12/25.
//

import SwiftUI

/// ContentView serves as the main view of the application.
/// Displays a black background with a floating action button for adding new content.
///
/// - Note: Follows Apple HIG guidelines for floating action buttons
struct ContentView: View {
    // MARK: - Properties
    
    /// View model for handling user interactions
    @StateObject private var viewModel = ContentViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Button(action: {
                    do {
                        try viewModel.handleAddButtonTapped()
                    } catch {
                        print("Error: \(error.localizedDescription)")
                        // TODO: Show error alert to user
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.bottom, 30)
                .accessibilityLabel("Add new item")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
