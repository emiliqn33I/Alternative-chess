//
//  ChessPiece.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//

import Foundation

struct Position {
    enum Rank: Int, CaseIterable {
        case first
        case second
        case third
        case fourth
        case fifth
        case sixth
        case seventh
        case eighth
    }
    enum File: Int , CaseIterable{
        case A
        case B
        case C
        case D
        case E
        case F
        case G
        case H
    }
    var file: File?
    var rank: Rank?
    init(file: File?, rank: Rank?) {
        self.file = file
        self.rank = rank
    }
    mutating func canChnageFile(delta: Int) -> Piece? {
        var chessEngine = ChessEngine()
        chessEngine.initialiseGame()
        let pieces = chessEngine.pieces
        if ((delta + (file?.rawValue ?? 100) >= 0) && (delta + (file?.rawValue ?? 100) <= 7)) {
            let result = pieces.filter( { $0.position.file?.rawValue ?? 1000 == (delta + (file?.rawValue ?? 100)) } )
            if (result.isEmpty) {
                return nil
            }
            return result[0]
        }
        return nil
    }
    mutating func canChnageRank(delta: Int) -> Piece? {
        var chessEngine = ChessEngine()
        chessEngine.initialiseGame()
        let pieces = chessEngine.pieces
        if ((delta + (rank?.rawValue ?? 100) >= 0) && (delta + (rank?.rawValue ?? 100) <= 7)) {
            let result = pieces.filter( { $0.position.rank?.rawValue ?? 1000 == (delta + (rank?.rawValue ?? 100))} )
            if (result.isEmpty) {
                return nil
            }
            return result[0]
        }
        return nil
    }
}

struct Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.position.file == rhs.position.file && lhs.position.rank == rhs.position.rank
    }
    
    
    enum PieceType {
        case pawn
    }
    enum Color {
        case white
        case black
    }
    var position: Position
    var type: PieceType
    var colour: Color
    
    init(type: PieceType, colour: Color, position: Position) {
        self.type = type
        self.colour = colour
        self.position = position
    }
}
