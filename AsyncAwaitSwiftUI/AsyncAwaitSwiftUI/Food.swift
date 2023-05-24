//
//  Food.swift
//  AsyncAwaitSwiftUI
//
//  Created by Sedhom, Mina R on 5/24/23.
//

import Foundation

struct Food: Identifiable, Decodable {
    var id: Int
    var uid: String
    var dish: String
    var description: String
    var ingredient: String
    var measurement: String
}
