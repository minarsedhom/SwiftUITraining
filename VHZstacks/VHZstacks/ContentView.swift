//
//  ContentView.swift
//  VHZstacks
//
//  Created by Sedhom, Mina R on 5/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Text("Contact Example")
                    .font(.title)
                    .foregroundColor(.white)
                VStack{
                    ZStack{
                        Circle()
                            .fill(Color(red: 0.1, green: 0.2, blue: 0.45))
                            .frame(width: 150, height: 150)
                        Text("MS")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    VStack(spacing: 10){
                        Text("Mina Sedhom")
                            .font(.title)
                        Text("SWE Intern")
                            .font(.body)
                    }
                    .foregroundColor(.white)

                    VStack(spacing: 20){
                        HStack{
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "phone")
                                    Text("Call")
                                }
                            }
                            .frame(minWidth: 70)
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(9)
                            
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "message")
                                    Text("Message")
                                }
                            }
                            .frame(minWidth: 70)
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(9)
                        }
                    }.padding(20)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
