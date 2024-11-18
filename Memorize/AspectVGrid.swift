//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Robert Fasciano on 10/20/24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var localLastChange: String
    
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, lastChange: (Int, String), @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        let (a, b) = lastChange
        self.localLastChange = String(a) + b
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item) //creates a view from an item
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
                .id(localLastChange) //needed to add this to ensure ForEach gets refreshed (allowing score number to be brought forward in Z
                //https://stackoverflow.com/questions/78584927/zindex-in-lazyvgrid-is-not-updated-on-redraw
            }
        }
    }
    
    
    func gridWidthThatFits (
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

