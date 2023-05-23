//
//  ContentView.swift
//  StateObjectVSObservedObject
//
//  Created by Sedhom, Mina R on 5/23/23.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0

       var body: some View {
           VStack {
               //This view has a State property of count. Every time the button is tapped, count is increased by one and the body of view will be redrawn, this includes redrawing UserView. Since the data of userViewModel is stored in the UserView, updating count won’t affect UserView.
               UserView()

               Button {
                   count += 1
               } label: {
                   Text("\(count)")
               }
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
