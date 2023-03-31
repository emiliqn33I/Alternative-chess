//
//  Move.swift
//  AlternativeChess
//
//  Created by emo on 13.02.23.
//

import Foundation

struct Move {
    enum MoveType: Equatable {
        case promotion(promoted: Piece)
        case take(taken: Piece)
        case castle(rook: Piece)
        case enPassant(takenPawn: Piece)
        case move
    }
    
    enum KingEffect: Equatable {
        case check(checkedKing: Piece)
        case mate(matedKing: Piece)
    }
    
    let piece: Piece
    let from: Position
    let to: Position
    let type: MoveType
    var kingEffect: KingEffect?
    var notationOfMove: String?
    
    init(piece: Piece, from: Position, to: Position, type: MoveType = .move, kingEffect: KingEffect? = nil, notationOfMove: String? = nil) {
        self.piece = piece
        self.from = from
        self.to = to
        self.type = type
        self.kingEffect = kingEffect
        self.notationOfMove = notationOfMove
    }
    
    func makeNotation(from move: Move) -> String? {
        return "zdr"
    }
}

extension Move: Equatable {
    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.piece == rhs.piece && lhs.from == rhs.from && lhs.to == rhs.to && lhs.type == rhs.type && lhs.kingEffect == rhs.kingEffect && lhs.notationOfMove == rhs.notationOfMove
    }
}
