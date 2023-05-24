//
//  ContentView.swift
//  AsyncAwaitSwiftUI
//
//  Created by Sedhom, Mina R on 5/24/23.
//

import SwiftUI

struct ContentView: View {
    let network = Network()
    @State private var food = Food(id: 0, uid: "", dish: "", description: "", ingredient: "", measurement: "")
    
    var body: some View {
        VStack {
            Text(food.description)
            
            AsyncImage(url: URL(string: "https://images.squarespace-cdn.com/content/v1/5c74288d9b8fe8141c2f96cd/1555288602717-ILN9Q2I0BE0JGPJC9SHC/closup-of-cat-on-floor-julie-austin-pet-photography.jpg")) { image in
                image.resizable()
            } placeholder: { Color.red }
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .padding()
        .task {
                do {
                        food = try await network.getRandomFood()
                } catch {
                        print("Error", error)
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
