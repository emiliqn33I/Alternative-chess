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
        case check
        case mate
    }

    let piece: Piece
    let from: Position
    let to: Position
    let type: MoveType
    var kingEffect: KingEffect?

    init(piece: Piece, from: Position, to: Position, type: MoveType = .move, kingEffect: KingEffect? = nil) {
        self.piece = piece
        self.from = from
        self.to = to
        self.type = type
        self.kingEffect = kingEffect
    }
}
