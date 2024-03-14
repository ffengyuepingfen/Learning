//
//  CategoryHome.swift
//  Landmarks
//
//  Created by JianjiaCoder on 2021/10/13.
//

import SwiftUI

struct CategoryHome: View {
    
    @EnvironmentObject var appData: AppModel
    @State private var showingProfile = false
    
    
    var body: some View {
        List {
            appData.landmarkModel.features[0].image
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
            
            ForEach(appData.landmarkModel.categories.keys.sorted(), id: \.self) { key in
                CategoryRow(categoryName: key, items: appData.landmarkModel.categories[key]!)
            }
            .listRowInsets(EdgeInsets())
        }
        .listStyle(InsetListStyle())
        .toolbar {
            Button(action: { showingProfile.toggle() }) {
                Image(systemName: "person.crop.circle")
                    .accessibilityLabel("User Profile")
            }
        }
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
                .environmentObject(appData.landmarkModel)
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(AppModel())
    }
}
