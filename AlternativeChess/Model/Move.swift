//
//  Move.swift
//  AlternativeChess
//
//  Created by emo on 13.02.23.
//

import Foundation

struct Move {
    var piece: Piece
    var from: Position
    var to: Position
    
    init(piece: Piece, from: Position, to: Position) {
        self.piece = piece
        self.from = from
        self.to = to
    }
}
