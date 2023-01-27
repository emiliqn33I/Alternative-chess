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
        boardView?.pieces = chessEngine.pieces
        
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
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
        drawPieces()
    }
    
    func drawBoard() {
        var board = Board()
        // board.renewBoard()
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
        // var chessEngine = ChessEngine()
        // chessEngine.initialiseGame()
        // pieces = chessEngine.pieces
        var chessBoard = Board()
        // chessBoard.renewBoard()
        let sq : [[Square]] = Array(chessBoard.squares.reversed())
        let side = bounds.width / CGFloat(ChessBoardView.squaresInRow)
        
        for row in 0...7 {
            for file in 0...7 {
                if(sq[row][file].piece != nil) {
                    switch sq[row][file].piece?.colour {
                    case .white :
                        switch sq[row][file].piece?.type {
                        case .pawn :
                            let pieceImage = UIImage(named: "w_pawn")
                            pieceImage?.draw(in: CGRect(x: CGFloat(file) * side, y: CGFloat(row) * side, width: side, height: side ))
                        default:
                            print(" ")
                        }
                    case .black :
                        switch sq[row][file].piece?.type {
                        case .pawn :
                            let pieceImage = UIImage(named: "b_pawn")
                            pieceImage?.draw(in: CGRect(x: CGFloat(row) * side, y: CGFloat(file) * side, width: side, height: side ))
                        default:
                            print(" ")
                        }
                    default:
                        print(" ")
                    }
                }
            }
        }
    }
}
