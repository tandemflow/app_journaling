//
//  ContentView.swift
//  app_journaling
//
//  Created by Garrett Nelson on 2/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button(action: {
                    // Action to be added later
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    ContentView()
}
