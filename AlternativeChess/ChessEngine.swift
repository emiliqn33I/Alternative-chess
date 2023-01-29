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
        //Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first)),
        Piece(type: .rook, colour: .white, position: Position(file: .E, rank: .fourth)),
        Piece(type: .bishop, colour: .white, position: Position(file: .F, rank: .first)),
        Piece(type: .bishop, colour: .white, position: Position(file: .G, rank: .third))

    ]

    // MARK: Public methods
    func possibleMoves(piece: Piece) -> [Position] {
        switch piece.type {
        case .pawn:
            return possiblePawnMoves(pawn: piece)
        case .rook:
            return possibleRookMoves(rook: piece)
        case .bishop:
            return possibleBishopMoves(bishop: piece)
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
    
    private func changedPositionFileAndRank(for checkPiece: Piece, fileDelta: Int, rankDelta: Int) -> Position? {
        let positionAtFileRank = checkPiece.position.changed(fileDelta: fileDelta, rankDelta: rankDelta)
        if piece(at: positionAtFileRank) == nil {
            return positionAtFileRank
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
    
    private func incrementRankAndFile(file: Bool, rank: Bool, incrementFile: Int, incrementRank: Int) -> [Int] {
        var array = [Int]()
        
        if file && rank {
            array.append(incrementFile + 1)
            array.append(incrementRank + 1)
        }
        if file && (rank == false) {
            array.append(incrementFile + 1)
            array.append(incrementRank - 1)
        }
        if (file == false) && rank {
            array.append(incrementFile - 1)
            array.append(incrementRank + 1)
        }
        if (file == false) && (rank == false) {
            array.append(incrementFile - 1)
            array.append(incrementRank - 1)
        }
        
        return array
    }
    
    
    private func appendFileOrRank(fileOrRank: Bool, piece: Piece, incrementWith: Int) -> [Position] {
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
    
    private func appendFileAndRank(piece: Piece, incrementFile: Int, incrementRank: Int) -> [Position] {
        var coordinates = [Position]()
        
        if let position = changedPositionFileAndRank(for: piece, fileDelta: incrementFile, rankDelta: incrementRank) {
            coordinates.append(position)
        }
        
        return coordinates
    }
    
    private func iteratingThroughFilesOrRanks(piece: Piece, upOrLower: Bool, fileOrRank: Bool) -> [Position] {
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
    
    private func iteratingThroughFilesAndRanks(piece: Piece, upOrLower: Bool, rightOrLeft: Bool) -> [Position] {
        var coordinates = [Position]()
        
        var file = giveFileOrRank(type: true, piece: piece)
        var rank = giveFileOrRank(type: false, piece: piece)
        var fileBishop = upperOrLower(direction: rightOrLeft)[0]
        var rankBishop = upperOrLower(direction: upOrLower)[0]
        let finalFile = upperOrLower(direction: rightOrLeft)[1]
        let finalRank = upperOrLower(direction: upOrLower)[1]
        
        //print(rankBishop)
        while((file != finalFile) && (rank != finalRank)) {
            coordinates += appendFileAndRank(piece: piece, incrementFile: fileBishop, incrementRank: rankBishop)
            
            fileBishop = incrementRankAndFile(file: rightOrLeft, rank: upOrLower, incrementFile: fileBishop, incrementRank: rankBishop)[0]
            rankBishop = incrementRankAndFile(file: rightOrLeft, rank: upOrLower, incrementFile: fileBishop, incrementRank: rankBishop)[1]
            file = incrementRankOrFile(type: rightOrLeft, incrementWith: file, rookPosition: 1)[0]
            rank = incrementRankOrFile(type: upOrLower, incrementWith: rank, rookPosition: 1)[0]
        }
        
        return coordinates
    }

    
    private func possibleBishopMoves(bishop: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: true, rightOrLeft: false)
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: true, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: false, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: false, rightOrLeft: false)
        
        return coordinates
    }
}
