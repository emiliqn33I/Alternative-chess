//
//  ChessBoard.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//

import Foundation

struct Square {
    enum Color {
        case white
        case black
    }
    let color: Color
    var sideOfSquare = 0.0
    var piece: Piece?
}

struct Board {
    
    var squares: [[Square]] = {
        var board: [[Square]] = []
        for row in 0 ..< ChessBoardView.squaresInRow {
            board.append([])
            for column in 0 ..< ChessBoardView.squaresInRow {
                let squareColor: Square.Color = (row + column).isMultiple(of: 2) ? .white : .black
                board[row].append(Square(color: squareColor, piece: nil))
            }
        }
        return board
    }()
    
    mutating func renewBoard() {
        var chessEngine = ChessEngine()
        chessEngine.initialiseGame()
        let pieces = chessEngine.pieces
        for row in 0...7 {
            for flank in 0...7 {
                for i in pieces {
                    if((row == i.position.rank?.rawValue) && (flank == i.position.file?.rawValue)) {
                        squares[row][flank].piece = i
                    }
                }
            }
        }
    }
}
