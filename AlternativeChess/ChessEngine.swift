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
            [Piece(type: .rook, colour: .black, file: .A, rank: .eighth),
             Piece(type: .none, colour: .none, file: .B, rank: .eighth),
             Piece(type: .none, colour: .none, file: .C, rank: .eighth),
             Piece(type: .none, colour: .none, file: .D, rank: .eighth),
             Piece(type: .none, colour: .none, file: .E, rank: .eighth),
             Piece(type: .none, colour: .none, file: .F, rank: .eighth),
             Piece(type: .none, colour: .none, file: .G, rank: .eighth),
             Piece(type: .rook, colour: .black, file: .H, rank: .eighth)],// 8 rank
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
             Piece(type: .none, colour: .none, file: .B, rank: .fourth),
             Piece(type: .none, colour: .none, file: .C, rank: .fourth),
             Piece(type: .none, colour: .none, file: .D, rank: .fourth),
             Piece(type: .none, colour: .none, file: .E, rank: .fourth),
             Piece(type: .none, colour: .none, file: .F, rank: .fourth),
             Piece(type: .none, colour: .none, file: .G, rank: .fourth),
             Piece(type: .none, colour: .none, file: .H, rank: .fourth)],// 4 rank
            [Piece(type: .none, colour: .none, file: .A, rank: .third),
             Piece(type: .none, colour: .none, file: .B, rank: .third),
             Piece(type: .none, colour: .none, file: .C, rank: .third),
             Piece(type: .none, colour: .none, file: .D, rank: .third),
             Piece(type: .none, colour: .none, file: .E, rank: .third),
             Piece(type: .none, colour: .none, file: .F, rank: .third),
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
            [Piece(type: .rook, colour: .white, file: .A, rank: .first),
             Piece(type: .none, colour: .none, file: .B, rank: .first),
             Piece(type: .none, colour: .none, file: .C, rank: .first),
             Piece(type: .none, colour: .none, file: .D, rank: .first),
             Piece(type: .none, colour: .none, file: .E, rank: .first),
             Piece(type: .none, colour: .none, file: .F, rank: .first),
             Piece(type: .none, colour: .none, file: .G, rank: .first),
             Piece(type: .rook, colour: .white, file: .H, rank: .first)]//1 rank
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
        case .rook:
            switch piece.colour {
            case .white:
                coordinates += possbileRookLikeMoves(piece: piece)
            case .black:
                coordinates += possbileRookLikeMoves(piece: piece)
            case .none:
                print("case not handler")
            }

        case .none:
            print("case not handler")
        }
        return coordinates
    }
    
    func possbileRookLikeMoves(piece: Piece) -> [(String, Int)] {
        var coordinates = [(String, Int)]()
        let pieceIsWhite = (piece.colour == .white)
        let pieceIsBlack = (piece.colour == .black)
    
        var counterUp = 1 // This counter allows us to give to the user right coordinates.
        var rankUp = piece.rank.value // Default rank of our piece, by decreasing we swicth to un upper rank.
        while (rankUp > 0) {
            let upperRankPieceIsBlack = (pieces[rankUp - 1][piece.file.value].colour == .black)
            let upperRankPieceIsWhite = (pieces[rankUp - 1][piece.file.value].colour == .white)
            let upperRankDoesntHavePiece = (pieces[rankUp - 1][piece.file.value].type == .none)
            
            if (pieceIsWhite) {
                if (upperRankPieceIsBlack) {
                    coordinates.append((piece.file.name, piece.rank.name + counterUp))
                    break
                }
                if (upperRankPieceIsWhite) {
                    break
                }
                if (upperRankDoesntHavePiece) {
                    coordinates.append((piece.file.name, piece.rank.name + counterUp))
                }
                counterUp += 1
                rankUp -= 1
            }
            if (pieceIsBlack) {
                if (upperRankPieceIsBlack) {
                    break
                }
                if (upperRankPieceIsWhite) {
                    coordinates.append((piece.file.name, piece.rank.name + counterUp))
                    break
                }
                if (upperRankDoesntHavePiece) {
                    coordinates.append((piece.file.name, piece.rank.name + counterUp))
                }
                counterUp += 1
                rankUp -= 1
            }
        }
        
        var counterDown = 1
        var rankDown = piece.rank.value
        while (rankDown < 7) {
            let lowerRankPieceIsBlack = (pieces[rankDown + 1][piece.file.value].colour == .black)
            let lowerRankPieceIsWhite = (pieces[rankDown + 1][piece.file.value].colour == .white)
            let lowerRankDoesntHavePiece = (pieces[rankDown + 1][piece.file.value].colour == .none)
            
            if (pieceIsWhite) {
                if (lowerRankPieceIsBlack) {
                    coordinates.append((piece.file.name, piece.rank.name - counterDown))
                    break
                }
                if (lowerRankPieceIsWhite) {
                    break
                }
                if (lowerRankDoesntHavePiece) {
                    coordinates.append((piece.file.name, piece.rank.name - counterDown))
                }
                counterDown += 1
                rankDown += 1
            }
            if (pieceIsBlack) {
                if (lowerRankPieceIsBlack) {
                    break
                }
                if (lowerRankPieceIsWhite) {
                    coordinates.append((piece.file.name, piece.rank.name - counterDown))
                    break
                }
                if (lowerRankDoesntHavePiece) {
                    coordinates.append((piece.file.name, piece.rank.name - counterDown))
                }
                counterDown += 1
                rankDown += 1
            }
        }

        var fileLeft = piece.file.value
        while (fileLeft > 0) {
            let leftFileIsBlack = (pieces[piece.rank.value][fileLeft - 1].colour == .black)
            let leftFileIsWhite = (pieces[piece.rank.value][fileLeft - 1].colour == .white)
            let leftFileDoesntHavePiece = (pieces[piece.rank.value][fileLeft - 1].type == .none)
            
            if (pieceIsWhite) {
                if (leftFileIsBlack) {
                    coordinates.append((pieces[piece.rank.value][fileLeft - 1].file.name, piece.rank.name))
                    break
                }
                if (leftFileIsWhite) {
                    break
                }
                if (leftFileDoesntHavePiece) {
                    coordinates.append((pieces[piece.rank.value][fileLeft - 1].file.name, piece.rank.name))
                }
                fileLeft -= 1
            }
            if (pieceIsBlack) {
                if (leftFileIsWhite) {
                    coordinates.append((pieces[piece.rank.value][fileLeft - 1].file.name, piece.rank.name))
                    break
                }
                if (leftFileIsBlack) {
                    break
                }
                if (leftFileDoesntHavePiece) {
                    coordinates.append((pieces[piece.rank.value][fileLeft - 1].file.name, piece.rank.name))
                }
                fileLeft -= 1
            }
        }
        
        var fileRight = piece.file.value
        while (fileRight < 7) {
            let rightFilePieceIsBlack = (pieces[piece.rank.value][fileRight + 1].colour == .black)
            let rightFilePieceIsWhite = (pieces[piece.rank.value][fileRight + 1].colour == .white)
            let rightFileDoesntHavePiece = (pieces[piece.rank.value][fileRight + 1].type == .none)
            
            if (pieceIsWhite) {
                if (rightFilePieceIsBlack) {
                    coordinates.append((pieces[piece.rank.value][fileRight + 1].file.name, piece.rank.name))
                    break
                }
                if (rightFilePieceIsWhite) {
                    break
                }
                if (rightFileDoesntHavePiece) {
                    coordinates.append((pieces[piece.rank.value][fileRight + 1].file.name, piece.rank.name))
                }
                fileRight += 1
            }
            if (pieceIsBlack) {
                if (rightFilePieceIsWhite) {
                    coordinates.append((pieces[piece.rank.value][fileRight + 1].file.name, piece.rank.name))
                    break
                }
                if (rightFilePieceIsBlack) {
                    break
                }
                if (rightFileDoesntHavePiece) {
                    coordinates.append((pieces[piece.rank.value][fileRight + 1].file.name, piece.rank.name))
                }
                fileRight += 1
            }
        }
        return coordinates
    }
}
