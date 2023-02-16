//
//  ViewController.swift
//  AlternativeChess
//
//  Created by Petar Bel on 15.12.22.
//

import UIKit

class ChessBoardViewController: UIViewController {
    
    @IBOutlet weak var boardView: ChessBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        
        let parentView = boardView
        
        let squareSize = parentView!.bounds.width / 8
        
        for row in 0..<8 {
            for col in 0..<8 {
                let xPosition = CGFloat(col) * squareSize
                let yPosition = CGFloat(row) * squareSize
                let squareFrame = CGRect(x: xPosition, y: yPosition, width: squareSize, height: squareSize)
                let squareView = UIView(frame: squareFrame)
                squareView.backgroundColor = (row + col) % 2 == 0 ? UIColor.white : UIColor.black
                parentView!.addSubview(squareView)
            }
        }
    }
    
    let board = ChessBoardView()
    
}

class ChessBoardView: UIView {
    static let squaresInRow = 8
    var pieces = [Piece]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        drawBoard()
    }
    
    func drawBoard() {
        var board = Board()
        let side = bounds.width / CGFloat(ChessBoardView.squaresInRow)
        var row = 0
        
        for(_, item) in board.squares.enumerated() {
            var counter = 0
            for square in item {
                let path = UIBezierPath(rect: CGRect(x: CGFloat(counter) * side, y: CGFloat(row) * side, width: side, height: side))
                if (square.color == .white) {
                    let blackColor = UIColor.white
                    blackColor.setStroke()
                    UIColor.white.setFill()
                    path.fill()
                    board.squares[row][counter].sideOfSquare = Double(side)
                } else {
                    let blackColor = UIColor.black
                    blackColor.setStroke()
                    UIColor.black.setFill()
                    path.fill()
                    board.squares[row][counter].sideOfSquare = Double(side)
                }
                counter += 1
            }
            row += 1
        }
    }
}


