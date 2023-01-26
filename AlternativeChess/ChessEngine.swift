//
//  ChessEngine.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//

import Foundation

struct ChessEngine {
    var pieces = [Piece]()

    mutating func initialiseGame() {
        pieces = [
            Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second)),
            Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .third))
        ]
        
    }

    func possibleMoves(piece: Piece) -> [Position] {
        switch piece.type {
        case .pawn:
            return possiblePawnMoves(pawn: piece)
        default:
            return []
        }
    }

    func piece(at position: Position) -> Piece? {
        pieces.first { $0.position == position }
    }

    func changedPositionRank(for checkPiece: Piece, delta: Int) -> Position? {
        let positionAtRank = checkPiece.position.changedRank(delta: delta)
        if piece(at: positionAtRank) == nil {
            return positionAtRank
        }
        return nil
    }

    func possiblePawnMoves(pawn: Piece) -> [Position] {
        var coordinates = [Position]()
        if pawn.colour == .white {
            if pawn.position.rank == .second {
                for i in 1...2 {
                    if let position = changedPositionRank(for: pawn, delta: i) {
                        coordinates.append(position)
                    }
                }
            } else if pawn.position.rank != .eighth {
                if let position = changedPositionRank(for: pawn, delta: 1) {
                    coordinates.append(position)
                }
            }
        }
        return coordinates
    }
}
