//
//  LandmarkList.swift
//  Landmarks
//
//  Created by JianjiaCoder on 2021/10/13.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var appData: AppModel
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        appData.landmarkModel.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
            && (filter == .all || filter.rawValue == landmark.category.rawValue)
        }
    }
    
    @State private var filter = FilterCategory.all
    @State private var selectedLandmark: Landmark?
    enum FilterCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
        
        var id: FilterCategory { self }
    }
    
    var title: String {
        let title = filter == .all ? "Landmarks" : filter.rawValue
        return showFavoritesOnly ? "Favorite \(title)" : title
    }
    
    var index: Int? {
        appData.landmarkModel.landmarks.firstIndex(where: { $0.id == selectedLandmark?.id })
    }
    
    var body: some View {
        VStack {
            List(selection: $selectedLandmark) {
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                    .tag(landmark)
                }
            }
            .frame(minWidth: 300)
            .toolbar {
                ToolbarItem {
                    Menu {
                        
                        Picker("Category", selection: $filter) {
                            ForEach(FilterCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(.inline)
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Favorites only", systemImage: "star.fill")
                        }
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
            Text("Select a Landmark")
        }
        .focusedValue(\.selectedLandmark, $appData.landmarkModel.landmarks[index ?? 0])
    }
    
    
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(AppModel())
    }
}
