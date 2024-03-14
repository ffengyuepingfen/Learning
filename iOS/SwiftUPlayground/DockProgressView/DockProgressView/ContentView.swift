//
//  ContentView.swift
//  DockProgressView
//
//  Created by Laowang on 2024/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var dockprogress: DockProgress = .shared
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Style", selection: $dockprogress.type) {
                ForEach(DockProgress.ProgressType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
                .pickerStyle(.inline)
            }
            
            Toggle("Show Dock Progress", isOn: $dockprogress.isVisible)
                .toggleStyle(.switch)
        }
        .padding()
        .frame(width: 400, height: 200)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            if dockprogress.isVisible {
                
                if dockprogress.progress >= 1.0 {
                    dockprogress.isVisible = false
                    dockprogress.progress = 0.0
                }else {
                    dockprogress.progress += 0.007
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
