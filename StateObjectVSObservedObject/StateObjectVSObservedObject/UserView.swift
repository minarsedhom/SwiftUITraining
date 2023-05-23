//
//  ContentView.swift
//  StateObjectVSObservedObject
//
//  Created by Sedhom, Mina R on 5/23/23.
//

import SwiftUI

class UserViewModel: ObservableObject {

    @Published var user: User

    init(user: User) {
        self.user = user
    }
}

struct User {
    var name: String
}

struct UserView: View {
    // The data is owned by the view. In other words, data of a StateObject is stored in the view, so the view won’t lose the data during redrawing.
    //@StateObject var userViewModel = UserViewModel(user: User(name: "Mina"))
    
    @ObservedObject var userViewModel = UserViewModel(user: User(name: "Mina"))

    
    var body: some View {
        Text(userViewModel.user.name)
            .onTapGesture {
                userViewModel.user.name += "+"
            }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

//When using @StateObject: This view has a State property of count. Every time the button is tapped, count is increased by one and the body of view will be redrawn, this includes redrawing UserView. Since the data of userViewModel is stored in the UserView, updating count won’t affect UserView.

//When using @ObserviedObject: It will be a different story if userViewModel is declared as an ObservedObject. The view won’t own the data. It creates a new instance of the object every time the view is redrawn. In other words, data isn’t stored in the view. When the view is redrawn, the data will be reset to the initial value.
