//
//  ContentView.swift
//  Views&Modifiers
//
//  Created by Sedhom, Mina R on 5/23/23.
//

import SwiftUI

// Custom modifier
// it’s usually a smart idea to create extensions on View that make them easier to use
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

//Another custom modifier
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}


//Custom view to use as a template
struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
    
}

struct ContentView: View {
    @State private var useRedText = false
    //computed  computed property view
    var motto1: some View {
        Text("Draco dormiens")
    }
    //
    let motto2 = Text("nunquam titillandus")
    
    //send multiple views back you have three options:
    // use V/HStack
    // use group -> layout agnostic
    // use @ViewBuilder to mimic the way swiftui works
    
    @ViewBuilder var spells: some View {
        Text("View1")
        Text("View2")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Hello, world!") {
                    print(type(of: self.body))
                }
                .frame(width: 200, height: 50)
                .background(.red)
                
                Text("Hello, world!")
                    .padding()
                    .background(.red)
                    .padding()
                    .background(.blue)
                    .padding()
                    .background(.green)
                    .padding()
                    .background(.yellow)
                    .foregroundColor(.white)
                
                
                //Conditional modifier -> ternary operator)
                Button("Click me") {
                    useRedText.toggle()
                }
                .foregroundColor(useRedText ? .red : .blue)
                
                //Environmet modifier
                
                // they behave subtly differently because if any of those child views override the same modifier,
                // -> The child’s version takes priority.
                //That won’t work / undo the same way: blur() is a regular modifier, so any blurs applied to child views are added to the VStack blur rather than replacing it.
                VStack {
                    Text("Gryffindor")
                        .font(.largeTitle)
                        .blur(radius: 0) //will not work
                    Text("Hufflepuff")
                        .blur(radius: 10)
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .font(.title)
                .blur(radius: 2)
                
                // Views as properties
                VStack {
                    motto1
                    motto2
                }
                HStack{
                    spells
                }
                
                //Custom view
                HStack(spacing: 10) {
                    CustomText(text: "First")
                        .foregroundColor(.white)
                    
                    CustomText(text: "Second")
                        .foregroundColor(.red)
                    
                }
                
                //Custom modifier
                Text("Custom modifier")
                    .titleStyle()
                //.modifier(Title())
                
                // using watermark custom modifier
                Color.indigo
                    .frame(width: 200, height: 100)
                    .watermarked(with: "watermark modifier")
                
                //new page contains custom container
                NavigationLink(destination: DetailView()) {
                    // destination view to navigation to
                    Text("Navigate Me To Details Page")
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


//The best way to think about it for now is to imagine that SwiftUI renders your view after every single modifier. So, as soon as you say .background(.red) it colors the background in red, regardless of what frame you give it. If you then later expand the frame, it won’t magically redraw the background – that was already applied.


//Swift silently applies a special attribute to the body property called @ViewBuilder. This has the effect of silently wrapping multiple views in one of those TupleView containers, so that even though it looks like we’re sending back multiple views they get combined into one TupleView.
