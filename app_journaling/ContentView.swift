//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/12/25.
//

import SwiftUI

struct ContentView: View {
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
                    // Action here
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
    }
}

#Preview {
    ContentView()
}
