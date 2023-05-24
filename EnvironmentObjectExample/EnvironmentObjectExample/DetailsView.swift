//
//  DetailsView.swift
//  EnvironmentObjectExample
//
//  Created by Sedhom, Mina R on 5/24/23.
//

import SwiftUI

// A view that expects to find a GameSettings object
// in the environment, and shows its score.
struct ScoreView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        Text("Score: \(settings.score)")
        Button("Decrease Score") {
            settings.score -= 1
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
