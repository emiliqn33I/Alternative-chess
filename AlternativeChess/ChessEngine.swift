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
        //Piece(type: .rook, colour: .white, position: Position(file: .E, rank: .fourth)),
        Piece(type: .bishop, colour: .white, position: Position(file: .F, rank: .first))

    ]

    // MARK: Public methods
    func possibleMoves(piece: Piece) -> [Position] {
        switch piece.type {
        case .pawn:
            return possiblePawnMoves(pawn: piece)
        case .rook:
            return possibleRookMoves(rook: piece)
        case .bishop:
            return possibleRookMoves(rook: piece)
        }
    }
    
    // MARK: Helper methods
    func piece(at position: Position) -> Piece? {
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
    
    private func upperOrLower(direction: Bool) -> [Int] {
        var array = [Int]()
        
        if direction {
            array.append(1)
            array.append(7)
        } else {
            array.append(-1)
            array.append(0)
        }
        
        return array
    }
    
    private func giveFileOrRank(type: Bool, piece: Piece) -> Int {
        if type {
            return piece.position.file.rawValue
        } else {
            return piece.position.rank.rawValue
        }
    }
    
    private func incrementRankOrFile(type: Bool, incrementWith: Int, rookPosition: Int) -> [Int] {
        var array = [Int]()
        
        if type {
            array.append(incrementWith + 1)
            array.append(rookPosition + 1)
        } else {
            array.append(incrementWith - 1)
            array.append(rookPosition - 1)
        }
        
        return array
    }
    
    func appendFileOrRank(fileOrRank: Bool, piece: Piece, incrementWith: Int) -> [Position] {
        var coordinates = [Position]()
        
        if fileOrRank {
            if let position = changedPositionFile(for: piece, delta: incrementWith) {
                coordinates.append(position)
            }
        } else {
            if let position = changedPositionRank(for: piece, delta: incrementWith) {
                coordinates.append(position)
            }
        }
        
        return coordinates
    }
    
    func iteratingThroughFilesOrRanks(piece: Piece, upOrLower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()
        var incrementWith = upperOrLower(direction: upOrLower)[0]
        let finalFileOrRank = upperOrLower(direction: upOrLower)[1]
        var rookPosition = giveFileOrRank(type: fileOrRank, piece: piece)
        
        while (rookPosition != finalFileOrRank) {
            coordinates += appendFileOrRank(fileOrRank: fileOrRank, piece: piece, incrementWith: incrementWith)
            incrementWith = incrementRankOrFile(type: upOrLower, incrementWith: incrementWith, rookPosition: rookPosition)[0]
            rookPosition = incrementRankOrFile(type: upOrLower, incrementWith: incrementWith, rookPosition: rookPosition)[1]
        }
        return coordinates
    }
    
    private func possibleRookMoves(rook: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: true, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: false, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: false, fileOrRank: true)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: true, fileOrRank: true)
        
        return coordinates
    }
}
