//
//  ChessEngine.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//

import Foundation

struct ChessEngine {
    var pieces = [[Piece]]()
    mutating func initialiseGame() {
        pieces = [
            [Piece(type: .none, colour: .none, file: .A, rank: .eighth),
             Piece(type: .none, colour: .none, file: .B, rank: .eighth),
             Piece(type: .none, colour: .none, file: .C, rank: .eighth),
             Piece(type: .none, colour: .none, file: .D, rank: .eighth),
             Piece(type: .none, colour: .none, file: .E, rank: .eighth),
             Piece(type: .none, colour: .none, file: .F, rank: .eighth),
             Piece(type: .none, colour: .none, file: .G, rank: .eighth),
             Piece(type: .none, colour: .none, file: .H, rank: .eighth)],// 8 rank
            [Piece(type: .pawn, colour: .black, file: .A, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .B, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .C, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .D, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .E, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .F, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .G, rank: .seventh),
             Piece(type: .pawn, colour: .black, file: .H, rank: .seventh)],// 7 rank
            [Piece(type: .none, colour: .none, file: .A, rank: .sixth),
             Piece(type: .none, colour: .none, file: .B, rank: .sixth),
             Piece(type: .none, colour: .none, file: .C, rank: .sixth),
             Piece(type: .none, colour: .none, file: .D, rank: .sixth),
             Piece(type: .none, colour: .none, file: .E, rank: .sixth),
             Piece(type: .none, colour: .none, file: .F, rank: .sixth),
             Piece(type: .none, colour: .none, file: .G, rank: .sixth),
             Piece(type: .none, colour: .none, file: .H, rank: .sixth)],// 6 rank
            [Piece(type: .none, colour: .none, file: .A, rank: .fifth),
             Piece(type: .none, colour: .none, file: .B, rank: .fifth),
             Piece(type: .none, colour: .none, file: .C, rank: .fifth),
             Piece(type: .none, colour: .none, file: .D, rank: .fifth),
             Piece(type: .none, colour: .none, file: .E, rank: .fifth),
             Piece(type: .none, colour: .none, file: .F, rank: .fifth),
             Piece(type: .none, colour: .none, file: .G, rank: .fifth),
             Piece(type: .none, colour: .none, file: .H, rank: .fifth)],// 5 rank
            [Piece(type: .none, colour: .none, file: .A, rank: .fourth),
             Piece(type: .pawn, colour: .white, file: .B, rank: .fourth),
             Piece(type: .none, colour: .none, file: .C, rank: .fourth),
             Piece(type: .none, colour: .none, file: .D, rank: .fourth),
             Piece(type: .none, colour: .none, file: .E, rank: .fourth),
             Piece(type: .none, colour: .none, file: .F, rank: .fourth),
             Piece(type: .none, colour: .none, file: .G, rank: .fourth),
             Piece(type: .none, colour: .none, file: .H, rank: .fourth)],// 4 rank
            [Piece(type: .none, colour: .none, file: .A, rank: .third),
             Piece(type: .pawn, colour: .white, file: .B, rank: .third),
             Piece(type: .none, colour: .none, file: .C, rank: .third),
             Piece(type: .none, colour: .none, file: .D, rank: .third),
             Piece(type: .none, colour: .none, file: .E, rank: .third),
             Piece(type: .pawn, colour: .black, file: .F, rank: .third),
             Piece(type: .none, colour: .none, file: .G, rank: .third),
             Piece(type: .none, colour: .none, file: .H, rank: .third)],// 3 rank
            [Piece(type: .pawn, colour: .white, file: .A, rank: .second),
             Piece(type: .pawn, colour: .white, file: .B, rank: .second),
             Piece(type: .pawn, colour: .white, file: .C, rank: .second),
             Piece(type: .pawn, colour: .white, file: .D, rank: .second),
             Piece(type: .pawn, colour: .white, file: .E, rank: .second),
             Piece(type: .pawn, colour: .white, file: .F, rank: .second),
             Piece(type: .pawn, colour: .white, file: .G, rank: .second),
             Piece(type: .pawn, colour: .white, file: .H, rank: .second)],// 2 rank
            [Piece(type: .none, colour: .none, file: .A, rank: .first),
             Piece(type: .none, colour: .none, file: .B, rank: .first),
             Piece(type: .none, colour: .none, file: .C, rank: .first),
             Piece(type: .none, colour: .none, file: .D, rank: .first),
             Piece(type: .none, colour: .none, file: .E, rank: .first),
             Piece(type: .none, colour: .none, file: .F, rank: .first),
             Piece(type: .none, colour: .none, file: .G, rank: .first),
             Piece(type: .none, colour: .none, file: .H, rank: .first)]//1 rank
            ]

    }
    func possibleMoves(piece: Piece) -> [(String, Int)] {

        var coordinates = [(String, Int)]()
        switch piece.type {
        case .pawn:
            switch piece.colour {
            case .white:
                let CheckWPawnOn2Rank = (piece.rank == .second)
                let CheckWPawnMove1Square = (pieces[piece.rank.value - 1][piece.file.value].type == .none)
                let CheckWPawnMove2Squares = (pieces[piece.rank.value - 2][piece.file.value].type == .none)
                if (CheckWPawnOn2Rank && CheckWPawnMove1Square && CheckWPawnMove2Squares) {
                    for i in 1...2 {
                        coordinates.append((piece.file.name, piece.rank.name + i))
                    }
                }
                let CheckWPNot8Rank = (piece.rank != .eighth)
                if (CheckWPNot8Rank && CheckWPawnMove1Square) {
                    var flag = false
                    for i in coordinates {
                        let CompareFilesIfAlreadyExisted = (i.0 == piece.file.name)
                        let CompareRanksIfAlreadyExisted = (i.1 == piece.rank.name + 1)
                        if (CompareFilesIfAlreadyExisted && CompareRanksIfAlreadyExisted) {
                            flag = true
                        }
                    }
                    if (flag == false) {
                        coordinates.append((piece.file.name, piece.rank.name + 1))
                    }
                }
                if (piece.file.value > 0) {
                    let CheckTakableLeftPieceBlack = (pieces[piece.rank.value - 1][piece.file.value - 1].colour == .black)
                    if (CheckTakableLeftPieceBlack) {
                        coordinates.append((pieces[piece.rank.value - 1][piece.file.value - 1].file.name, piece.rank.name + 1))
                    }
                }
                if (piece.file.value < 7) {
                    let CheckTakableRightPieceBlack = (pieces[piece.rank.value - 1][piece.file.value + 1].colour == .black)
                    if (CheckTakableRightPieceBlack) {
                        coordinates.append((pieces[piece.rank.value - 1][piece.file.value + 1].file.name, piece.rank.name + 1))
                    }
                }
            case .black:
                let CheckBPawnOn7Rank = (piece.rank == .seventh)
                let CheckBPawnMove1Square = (pieces[piece.rank.value + 1][piece.file.value].type == .none)
                let CheckBPawnMove2Squares = (pieces[piece.rank.value + 2][piece.file.value].type == .none)
                if (CheckBPawnOn7Rank && CheckBPawnMove1Square && CheckBPawnMove2Squares) {
                    for i in 1...2 {
                        coordinates.append((piece.file.name, piece.rank.name - i))
                    }
                }
                let CheckBPisNot1Rank = (piece.rank != .first)
                if (CheckBPisNot1Rank && CheckBPawnMove1Square) {
                    var flag = false
                    for i in coordinates {
                        if ((i.0 == piece.file.name) && (i.1 == piece.rank.name - 1)) {
                            flag = true
                        }
                    }
                    if (flag == false) {
                        coordinates.append((piece.file.name, piece.rank.name + 1))
                    }
                }
                if (piece.file.value > 0) {
                    let CheckTakableLeftPieceWhite = (pieces[piece.rank.value + 1][piece.file.value - 1].colour == .white)
                    if (CheckTakableLeftPieceWhite) {
                        coordinates.append(( pieces[piece.rank.value + 1][piece.file.value - 1].file.name,  piece.rank.name - 1))
                    }
                }
                if (piece.file.value < 7) {
                    let CheckTakableRightPieceWhite = pieces[piece.rank.value + 1][piece.file.value + 1].colour == .white
                    if (CheckTakableRightPieceWhite) {
                        coordinates.append((pieces[piece.rank.value + 1][piece.file.value + 1].file.name,  piece.rank.name - 1))
                    }
                }
            case .none:
                print("case not handler")
            }
        case .none:
            print("case not handler")
        }
        return coordinates
    }
}
