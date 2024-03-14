//
//  LandmarkCommands.swift
//  ChongdianMac
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct LandmarkCommands: Commands {
    // You’re reading the value here. You’ll set it later in the list view, where the user makes the selection.
    @FocusedBinding(\.selectedLandmark) var selectedLandmark
    
    var body: some Commands {
//        This built-in command set includes the command for toggling the sidebar.
        SidebarCommands()
        
        CommandMenu("Landmark") {
            // You’ll define content for the menu next.
            Button("\(selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
                selectedLandmark?.isFavorite.toggle()
            }
            // SwiftUI automatically shows the keyboard shortcut in the menu.
            .keyboardShortcut("f", modifiers: [.shift, .option])
            .disabled(selectedLandmark == nil)
        }
        
    }
}


// The pattern for defining focused values resembles the pattern for defining new Environment values:
// Use a private key to read and write a custom property on the system-defined FocusedValues structure.
private struct SelectedLandmarkKey: FocusedValueKey {
    typealias Value = Binding<Landmark>
}

extension FocusedValues {
    var selectedLandmark: Binding<Landmark>? {
        get { self[SelectedLandmarkKey.self] }
        set { self[SelectedLandmarkKey.self] = newValue }
    }
}
