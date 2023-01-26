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
            Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second))
        ]
        
    }
    func possibleMoves(piece: Piece) -> [Position] {

        var coordinates = [Position]()
        switch piece.type {
        case .pawn:
            coordinates += possiblePawnMoves(pawn1: piece)
        }
        return coordinates
    }


    func possiblePawnMoves(pawn1: Piece) -> [Position] {
        var pawn = pawn1
        var coordinates = [Position]()
        let pawnIsWhite = (pawn.colour == .white)
        
        if (pawnIsWhite) {
            let CheckWPawnOn2Rank = (pawn.position.rank == .second)
            let CheckWPawnMove1Square = (pawn.position.canChnageRank(delta: -1) == nil)
            let CheckWPawnMove2Squares = (pawn.position.canChnageRank(delta: -2) == nil)
            if (CheckWPawnOn2Rank && CheckWPawnMove1Square && CheckWPawnMove2Squares) {
                for i in 1...2 {
                    for aRank in Position.Rank.allCases {
                        if (aRank.rawValue == ((pawn.position.rank?.rawValue ?? 100 ) + i)) {
                            let position = Position(file: pawn.position.file, rank: aRank)
                            coordinates.append(position)
                            break
                        }
                    }
                }
            }
        }
        return coordinates
    }
}
