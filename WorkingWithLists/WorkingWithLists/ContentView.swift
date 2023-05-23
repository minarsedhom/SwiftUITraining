//
//  ContentView.swift
//  WorkingWithLists
//
//  Created by Sedhom, Mina R on 5/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var people = ["Finn", "Leia", "Luke", "Rey", "Finn", "Leia", "Luke", "Rey", "Finn", "Leia", "Luke", "Rey"]
    
    @State private var newPerson = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("People") {
                        ForEach(people, id: \.self) {
                            Text($0)
                        }
                        .onDelete(perform: removeRows)
                    }
                    
//                    Section("Section 1") {
//                        Text("Static row 1")
//                        Text("Static row 2")
//                    }
//
//                    Section("Section 2") {
//                        ForEach(0..<3) {
//                            Text("Dynamic row \($0)")
//                        }
//                    }
                }
                .listStyle(.grouped)
                
                HStack {
                    TextField("enter name", text: $newPerson)
                    Button("Add Person") {
                        people.append(newPerson)
                    }
                }
                .padding()
            }
            .navigationTitle("OnDelete")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
