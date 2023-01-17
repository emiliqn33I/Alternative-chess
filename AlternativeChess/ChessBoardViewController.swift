//
//  ViewController.swift
//  AlternativeChess
//
//  Created by Petar Bel on 15.12.22.
//

import UIKit

class ChessBoardViewController: UIViewController {
    
    var chessEngine = ChessEngine()
    
    @IBOutlet weak var boardView: ChessBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chessEngine.initialiseGame()
        boardView?.pieces = chessEngine.pieces
        
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
    }
    let board = ChessBoardView()
    
}

class ChessBoardView: UIView {
    static let squaresInRow = 8
    var pieces = [[Piece]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        drawBoard()
        drawPieces()
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
    
    func drawPieces() {
        var pieces: [[Piece]]
        var chesengine = ChessEngine()
        chesengine.initialiseGame()
        pieces = chesengine.pieces
        let side = bounds.width / CGFloat(ChessBoardView.squaresInRow)
        for piece in pieces {
            for i in piece {
                switch i.colour {
                    case .white :
                    switch i.type {
                    case .pawn :
                        let pieceImage = UIImage(named: "w_pawn")
                        pieceImage?.draw(in: CGRect(x: CGFloat(i.file.value) * side, y: CGFloat(i.rank.value) * side, width: side, height: side ))
                    case .none:
                        print("case not handed")
                    }
                    case .black :
                    switch i.type {
                    case .pawn :
                        let pieceImage = UIImage(named: "b_pawn")
                        pieceImage?.draw(in: CGRect(x: CGFloat(i.file.value) * side, y: CGFloat(i.rank.value) * side, width: side, height: side ))
                    case .none:
                        print("case not handed")
                    }
                    default:
                        print("case not handed")
                }
            }
        }
    }
}
