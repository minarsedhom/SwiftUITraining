//
//  BindingChildView.swift
//  EnvironmentObjectExample
//
//  Created by Sedhom, Mina R on 5/24/23.
//

import SwiftUI

// 1- create a state var in the parent View and read and write on it
// 2- create an @Binding property with no init value in the child view to bind it withthe parent view prop
// 3- You will have to pass the $ value of the state prop in the init when going to the new view AddView(parentValue: ---)
// 4- Now we binded/ shared the parent value with the child view. any changes from both sides will reflect.

struct AddView: View {
    //create
    @Binding var isPresented: Bool
    
    var body: some View {
        Button("Dismiss") {
            isPresented = false
        }
        
    }
}
