//
//  ContentView.swift
//  wat_r
//
//  Created by Ricky Kuang on 2/21/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var minuteIndex = 0
    var minutes = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $minuteIndex, label:
                            Text("Minute")) {
                        ForEach(0 ..< minutes.count) {
                            Text(self.minutes[$0]).tag($0)
                        }
                    }
                }
            }.navigationBarTitle(Text("Minutes"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
