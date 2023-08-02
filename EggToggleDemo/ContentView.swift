//
//  ContentView.swift
//  EggToggleDemo
//
//  Created by Evgeny Mitko on 31/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var isOn = false
    
    var body: some View {
        ZStack {
            Color.backgroundBlue
                .ignoresSafeArea(.all)
            
            Toggle("", isOn: $isOn)
                .toggleStyle(EggToggleStyle())
        }
    }
}

#Preview {
    ContentView()
}
