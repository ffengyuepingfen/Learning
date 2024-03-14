//
//  LandmarkDetail.swift
//  ChongdianWatch Watch App
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct LandmarkDetail: View {
    
    @EnvironmentObject var modelData: AppModel

    var landmarkIndex: Int {
        AppModel().landmarkModel.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var landmark: Landmark
    
    var body: some View {
        ScrollView {
            VStack {
                CircleImage(image: landmark.image.resizable())
                    .scaledToFit()
                
                Text(landmark.name)
                    .font(.headline)
                    .lineLimit(0)
                
                Toggle(isOn: $modelData.landmarkModel.landmarks[landmarkIndex].isFavorite) {
                    Text("Favorite")
                }
                
                Divider()
                
                Text(landmark.park)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)
                
                Text(landmark.state)
                    .font(.caption)
                
                Divider()
                
                MapView(coordinate: landmark.locationCoordinate)
                    .scaledToFit()
            }
            .padding()
        }
        .navigationTitle("Landmarks")
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: AppModel().landmarkModel.landmarks[0])
            .environmentObject(AppModel())
    }
}
