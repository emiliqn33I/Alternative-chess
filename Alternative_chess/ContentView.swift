//
//  ContentView.swift
//  Alternative_chess
//
//  Created by emo on 11.12.22.
//
import SwiftUI

struct Checkerboard: Shape {
    let rows = 8
    let columns = 8
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

// Create a checkerboard in a view
struct ContentView: View {
    var body: some View {
        Checkerboard()
            .fill(.black)
            .frame(width: 400, height: 400)
    }
}
    

