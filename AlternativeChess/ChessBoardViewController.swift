//
//  ViewController.swift
//  AlternativeChess
//
//  Created by Petar Bel on 15.12.22.
//

import UIKit

class ChessBoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
    }
    let board = ChessBoardView()
    
}

struct Square {
    enum Color {
        case white
        case black
    }
    let color: Color
    var sideOfSquare = 0.0
}

class ChessBoardView: UIView {
    static let squaresInRow = 8

    override init(frame: CGRect) {
         super.init(frame: frame)

     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
    
    var squares: [[Square]] = {
        var board: [[Square]] = []
        for row in 0 ..< ChessBoardView.squaresInRow {
            board.append([])
            for column in 0 ..< ChessBoardView.squaresInRow {
                let squareColor: Square.Color = (row + column).isMultiple(of: 2) ? .white : .black
                board[row].append(Square(color: squareColor))
            }
        }
        return board
    }()

    override func draw(_ rect: CGRect) {
        let side = bounds.width / CGFloat(ChessBoardView.squaresInRow)
        var row = 0
        for(_, item) in squares.enumerated() {
            var counter = 0
            for square in item {
                 if (square.color == .white) {
                     let path = UIBezierPath(rect: CGRect(x: CGFloat(counter) * side, y: CGFloat(row) * side, width: side, height: side))
                     let blackColor = UIColor.white
                     blackColor.setStroke()
                     UIColor.white.setFill()
                     path.fill()
                     squares[row][counter].sideOfSquare = Double(side)
                 }
                 else {
                     let path = UIBezierPath(rect: CGRect(x: CGFloat(counter) * side, y: CGFloat(row) * side, width: side, height: side))
                     let blackColor = UIColor.black
                     blackColor.setStroke()
                     UIColor.black.setFill()
                     path.fill()
                     squares[row][counter].sideOfSquare = Double(side)
                 }
                 counter += 1
             }
            row += 1
        }
    }
}
