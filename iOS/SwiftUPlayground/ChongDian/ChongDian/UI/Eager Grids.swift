//
//  Eager Grids.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/15.
//

import SwiftUI

struct Eager_Grids: View {
    var body: some View {
        Grid(alignment: .bottomTrailing, horizontalSpacing: 5.0, verticalSpacing: 5.0) {
            GridRow {
                CellView(color: .green, width: 80, height: 80)
                
                CellView(color: .yellow, width: 80, height: 80)
                    .gridColumnAlignment(.trailing)
                
                CellView(color: .orange, width: 80, height: 120)
            }
            
            GridRow(alignment: .bottom) {
                CellView(color: .green, width: 80, height: 80)
                
                CellView(color: .yellow, width: 80, height: 80)
                
                CellView(color: .orange, width: 80, height: 120)
            }
            
            GridRow {
                CellView(color: .green, width: 120, height: 80)
                
                CellView(color: .yellow, width: 120, height: 80)
                
                CellView(color: .orange, width: 80, height: 80)
            }
        }
    }
    
    struct CellView: View {
        let color: Color
        let width: CGFloat
        let height: CGFloat
        
        var body: some View {
            RoundedRectangle(cornerRadius: 5.0)
                .fill(color.gradient)
                .frame(width: width, height: height)
        }
    }
}

struct Eager_Grids_Previews: PreviewProvider {
    static var previews: some View {
        Eager_Grids()
    }
}
