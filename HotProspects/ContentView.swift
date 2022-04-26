//
//  ContentView.swift
//  HotProspects
//
//  Created by Evi St on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        List{
            Text("Bob the builder")
                .swipeActions {
                    Button(role: .destructive) {
                        print("deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading){
                    Button{
                        print("Pinning")
                    } label: {
                        Label("Pin",systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
