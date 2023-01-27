//
//  ChessEngine.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//
import Foundation

class ChessEngine {
    var pieces = [
        Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second)),
        Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .third)),
        Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first)),
        Piece(type: .rook, colour: .white, position: Position(file: .E, rank: .fourth))

    ]

    // MARK: Public methods
    func possibleMoves(piece: Piece) -> [Position] {
        switch piece.type {
        case .pawn:
            return possiblePawnMoves(pawn: piece)
        case .rook:
            return possibleRookMoves(rook: piece)
        }
    }
    
    // MARK: Helper methods
    private func piece(at position: Position) -> Piece? {
        pieces.first { $0.position == position }
    }

    private func changedPositionRank(for checkPiece: Piece, delta: Int) -> Position? {
        let positionAtRank = checkPiece.position.changedRank(delta: delta)
        if piece(at: positionAtRank) == nil {
            return positionAtRank
        }
        return nil
    }
    
    private func changedPositionFile(for checkPiece: Piece, delta: Int) -> Position? {
        let positionAtFile = checkPiece.position.changedFile(delta: delta)
        if piece(at: positionAtFile) == nil {
            return positionAtFile
        }
        return nil
    }

    private func possiblePawnMoves(pawn: Piece) -> [Position] {
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
    
    func iteratingThroughFilesOrRanks(piece: Piece, upperOrLower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()
        var delta: Int
        var finalFileOrRank: Int
        var rookPosition: Int
        
        if upperOrLower {
            delta = 1
            finalFileOrRank = 7
        } else {
            delta = -1
            finalFileOrRank = 0
        }
        
        if fileOrRank {
            rookPosition = piece.position.file.rawValue
        } else {
            rookPosition = piece.position.rank.rawValue
        }
        
        while (rookPosition != finalFileOrRank) {
            if fileOrRank {
                if let position = changedPositionFile(for: piece, delta: delta) {
                    coordinates.append(position)
                }
            } else {
                if let position = changedPositionRank(for: piece, delta: delta) {
                    coordinates.append(position)
                }
            }
            if upperOrLower {
                delta += 1
                rookPosition += 1
            } else {
                delta -= 1
                rookPosition -= 1
            }
        }
        return coordinates
    }
    
    private func possibleRookMoves(rook: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upperOrLower: true, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upperOrLower: false, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upperOrLower: false, fileOrRank: true)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upperOrLower: true, fileOrRank: true)
        
        return coordinates
    }
}
