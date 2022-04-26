//
//  ContentView.swift
//  HotProspects
//
//  Created by Evi St on 4/26/22.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send() // instead of @Published
        }
    }
    init() {
        for i in 1...10{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}


struct ContentView: View {
    @StateObject private var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
