//
//  Move.swift
//  AlternativeChess
//
//  Created by emo on 13.02.23.
//

import Foundation

struct Move {
    enum MoveType {
        case promotion(promoted: Piece)
        case take(taken: Piece)
        case castle(rook: Piece)
        case enPassant(takenPawn: Piece)
        case move
    }

    enum KingEffect {
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
}
