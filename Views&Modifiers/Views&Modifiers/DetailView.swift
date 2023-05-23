//
//  DetailView.swift
//  Views&Modifiers
//
//  Created by Sedhom, Mina R on 5/23/23.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
               ForEach(0..<rows, id: \.self) { row in
                   HStack {
                       ForEach(0..<columns, id: \.self) { column in
                           content(row, column)
                       }
                   }
               }
           }
    }
}


struct DetailView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
