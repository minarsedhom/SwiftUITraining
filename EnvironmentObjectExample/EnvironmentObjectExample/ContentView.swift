//
//  ContentView.swift
//  EnvironmentObjectExample
//
//  Created by Sedhom, Mina R on 5/24/23.
//


// @EnvironmentObject: For data that should be shared with many views in your app
//

import SwiftUI

// Our observable object class
class GameSettings: ObservableObject {
    @Published var score = 0
}

// A view that creates the GameSettings object,
// and places it into the environment for the
// navigation stack.
struct ContentView: View {
    @StateObject var settings = GameSettings()
    
    // for @binding demo
    @State private var showingAddUser = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Score: \(settings.score)")
                // A button that writes to the environment settings
                Button("Increase Score") {
                    settings.score += 1
                }
                
                NavigationLink {
                    ScoreView()
                } label: {
                    Text("Show Detail View")
                }
                
                // For @Binding Demo
                Button("Show sheet -> @Binding demo") {
                    showingAddUser.toggle()
                }
                //Passing the state bool to the childView init
                .sheet(isPresented: $showingAddUser) {
                    AddView(isPresented: $showingAddUser)
                }
                
            }
            .frame(height: 200)
        }
        .environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
