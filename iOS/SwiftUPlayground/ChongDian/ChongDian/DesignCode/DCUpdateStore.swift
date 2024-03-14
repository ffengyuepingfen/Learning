//
//  DCUpdateStore.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/7.
//

import SwiftUI
import Combine

class DCUpdateStore: ObservableObject {
    
    @Published var updates: [DCUpdate] = updateData
    
}

let updateData = [
    DCUpdate(image:"Card1", title:"SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    DCUpdate (image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    DCUpdate (image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date:"AUG 27"),
    DCUpdate (image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11",date: "JUNE 26"),
    DCUpdate (image: "Card5", title:"Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
    ]
