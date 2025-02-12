//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/5/25.
//

import SwiftUI

struct ContentView: View {
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
                    // Action to be added later
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.gray))
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
