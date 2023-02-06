//
//  ChessEngine.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//
import Foundation

class ChessEngine {
    var pieces: [Piece]
    
    init(pieces: [Piece]) {
        self.pieces = pieces
    }

    // MARK: Public methods
    func place(piece: Piece, at position: Position) -> Void {
        for aPiece in pieces {
            if aPiece.position == piece.position {
                if let index = pieces.firstIndex(of: aPiece) {
                    pieces[index].position = position
                }
            }
        }
    }
    
    
    func validMoves(for piece: Piece) -> [Position] {
        let possibleMoves = possibleMoves(piece: piece)
        // 1. King check logic
        let kingCheckMoves = kingCheckMoves(king(color: .white), for: possibleMoves, piece: piece)
        var validMoves = [Position]()
        
        for move in possibleMoves {
            var flag = true
            
            for moveCheck in kingCheckMoves {
                if move == moveCheck {
                    flag = false
                }
            }
            
            if flag {
                validMoves.append(move)
            }
        }
        return validMoves
    }

    // MARK: Helper methods

    func possibleMoves(piece: Piece) -> [Position] {
        switch piece.type {
        case .pawn:
            return possiblePawnMoves(pawn: piece)
        case .rook:
            return possibleRookMoves(rook: piece)
        case .bishop:
            return possibleBishopMoves(bishop: piece)
        case .knight:
            return possibleKnightMoves(knight: piece)
        case .queen:
            return possibleQueenMoves(queen: piece)
        case .king:
            return possibleKingMoves(king: piece)
        }
    }

    func king(color: Piece.Color) -> Piece {
        pieces.first { $0.type == .king && color == $0.colour }!
    }

    func kingCheckMoves(_ king: Piece, for possibleMoves: [Position], piece: Piece) -> [Position] {
        var checkPositions = [Position]()
        for move in possibleMoves {
            if isKingInCheck(king, at: move, piece: piece) {
                checkPositions.append(move)
            }
        }
        return checkPositions
    }

    func isKingInCheck(_ king: Piece, at position: Position, piece: Piece) -> Bool {
        var gameState = [Position]()
        
        for aPiece in pieces {
            gameState.append(aPiece.position)
        }
        
        place(piece: piece, at: position)
        
        for aPiece in pieces {
            let possiblePieceMoves = possibleMoves(piece: aPiece)
            if possiblePieceMoves.contains(king.position) {
                for i in pieces {
                    if let index = pieces.firstIndex(of: i) {
                        pieces[index].position = gameState[index]
                    }
                }
                return true
            }
        }
        return false
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
                    else {
                        break
                    }
                }
            } else if pawn.position.rank != .eighth {
                if let position = changedPositionRank(for: pawn, delta: 1) {
                    coordinates.append(position)
                }
            }
            
            coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: -1, incrementWithRank: 1)
            coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: 1, incrementWithRank: 1)
        } else {
            if pawn.position.rank == .seventh {
                for i in 1...2 {
                    if let position = changedPositionRank(for: pawn, delta: -i) {
                        coordinates.append(position)
                    }
                    else {
                        break
                    }
                }
            } else if pawn.position.rank != .first {
                if let position = changedPositionRank(for: pawn, delta: -1) {
                    coordinates.append(position)
                }
            }
            
            coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: -1, incrementWithRank: -1)
            coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: 1, incrementWithRank: -1)
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
    
    private func incrementRankAndFileKnight(file: Bool, rank: Bool, incrementFile: Int, incrementRank: Int) -> [Int] {
        var array = [Int]()
        
        if file && rank {
            array.append(incrementFile + 1)
            array.append(incrementRank + 2)
            array.append(incrementFile + 2)
            array.append(incrementRank + 1)
        }
        if file && (rank == false) {
            array.append(incrementFile + 1)
            array.append(incrementRank - 2)
            array.append(incrementFile + 2)
            array.append(incrementRank - 1)
        }
        if (file == false) && rank {
            array.append(incrementFile - 1)
            array.append(incrementRank + 2)
            array.append(incrementFile - 2)
            array.append(incrementRank + 1)
        }
        if (file == false) && (rank == false) {
            array.append(incrementFile - 1)
            array.append(incrementRank - 2)
            array.append(incrementFile - 2)
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
    
    func appendIfTakablePiece(piece: Piece, incrementWithFile: Int, incrementWithRank: Int) -> [Position] {
        var coordinates = [Position]()
        
        if pieceIsOpositeColorAtThatPosition(piece: piece, fileBishop: incrementWithFile, rankBishop: incrementWithRank) != nil {
            let oppositeColorPieceAtThatPosition = pieceIsOpositeColorAtThatPosition(piece: piece, fileBishop: incrementWithFile, rankBishop: incrementWithRank)
            coordinates.append(oppositeColorPieceAtThatPosition!)
        }
        
        return coordinates
    }
    
    private func iteratingThroughFilesOrRanks(piece: Piece, upOrLower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()
        
        var incrementWith = upperOrLower(direction: upOrLower)[0]
        let finalFileOrRank = upperOrLower(direction: upOrLower)[1]
        var rookPosition = giveFileOrRank(type: fileOrRank, piece: piece)
        
        while (rookPosition != finalFileOrRank) {
            if checkIsEmpty(positions: appendFileOrRank(fileOrRank: fileOrRank, piece: piece, incrementWith: incrementWith)) {
                if fileOrRank {
                    coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: incrementWith, incrementWithRank: 0)
                } else {
                    coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: 0, incrementWithRank: incrementWith)
                }
                break
            }
            coordinates += appendFileOrRank(fileOrRank: fileOrRank, piece: piece, incrementWith: incrementWith)
            incrementWith = incrementRankOrFile(type: upOrLower, incrementWith: incrementWith, rookPosition: rookPosition)[0]
            rookPosition = incrementRankOrFile(type: upOrLower, incrementWith: incrementWith, rookPosition: rookPosition)[1]
        }
        
        return coordinates
    }
    
    private func checkIsEmpty(positions: [Position]) -> Bool {
        return positions.isEmpty
    }
    
    private func possibleRookMoves(rook: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: true, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: false, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: false, fileOrRank: true)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: true, fileOrRank: true)
        
        return coordinates
    }
    
    func pieceIsOpositeColorAtThatPosition(piece: Piece, fileBishop: Int, rankBishop: Int) -> Position? {
        let newPos = piece.position.changed(fileDelta: fileBishop, rankDelta: rankBishop)
        let pieceAtThatPos = pieces.filter { $0.position == newPos && $0.colour != piece.colour}
        if pieceAtThatPos.count != 0 {
            return newPos
        }
        
        return nil
    }
    
    private func iteratingThroughFilesAndRanks(piece: Piece, upOrLower: Bool, rightOrLeft: Bool) -> [Position] {
        var coordinates = [Position]()
        
        var file = giveFileOrRank(type: true, piece: piece)
        var rank = giveFileOrRank(type: false, piece: piece)
        var fileBishop = upperOrLower(direction: rightOrLeft)[0]
        var rankBishop = upperOrLower(direction: upOrLower)[0]
        let finalFile = upperOrLower(direction: rightOrLeft)[1]
        let finalRank = upperOrLower(direction: upOrLower)[1]
        
        while((file != finalFile) && (rank != finalRank)) {
            if checkIsEmpty(positions: appendFileAndRank(piece: piece, incrementFile: fileBishop, incrementRank: rankBishop)) {
                coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: fileBishop, incrementWithRank: rankBishop)
                break
            }
            
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
    
    private func iteratingThroughFilesAndRanksForKnight(piece: Piece, upOrLower: Bool, rightOrLeft: Bool) -> [Position] {
        var coordinates = [Position]()
        var countFile = 0
        var countRank = 1
        
        for _ in 1...2 {
            var fileKnight = 0
            var rankKnight = 0
            
            fileKnight = incrementRankAndFileKnight(file: rightOrLeft, rank: upOrLower, incrementFile: fileKnight, incrementRank: rankKnight)[countFile]
            
            rankKnight = incrementRankAndFileKnight(file: rightOrLeft, rank: upOrLower, incrementFile: fileKnight, incrementRank: rankKnight)[countRank]

            var casesRank = [Int]()
            var casesFile = [Int]()
            
            for rank in Position.Rank.allCases {
                casesRank.append(rank.rawValue)
            }
            
            for file in Position.File.allCases {
                casesFile.append(file.rawValue)
            }
            
            if (casesRank.contains(piece.position.rank.rawValue + rankKnight)) && (casesFile.contains(piece.position.file.rawValue + fileKnight)) {
                coordinates += appendFileAndRank(piece: piece, incrementFile: fileKnight, incrementRank: rankKnight)
                coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: fileKnight, incrementWithRank: rankKnight)
            }
            
            countFile += 2
            countRank += 2
        }
        
        return coordinates
    }
    
    private func possibleKnightMoves(knight: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: true, rightOrLeft: false)
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: true, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: false, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: false, rightOrLeft: false)
        
        return coordinates
    }
    
    private func possibleQueenMoves(queen: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += possibleRookMoves(rook: queen)
        coordinates += possibleBishopMoves(bishop: queen)
        
        return coordinates
    }
    
    private func appendKingRookLikeMoves(king: Piece, upOrlower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()

        if iteratingThroughFilesOrRanks(piece: king, upOrLower: upOrlower, fileOrRank: fileOrRank).count != 0 {
            coordinates.append(iteratingThroughFilesOrRanks(piece: king, upOrLower: upOrlower, fileOrRank: fileOrRank)[0])
            
            return coordinates
        }
        
        return coordinates
    }
    
    private func appendKingBishopLikeMoves(king: Piece, upOrlower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()

        if iteratingThroughFilesAndRanks(piece: king, upOrLower: upOrlower, rightOrLeft: fileOrRank).count != 0 {
            coordinates.append(iteratingThroughFilesAndRanks(piece: king, upOrLower: upOrlower, rightOrLeft: fileOrRank)[0])
            
            return coordinates
        }
        
        return coordinates
    }

    private func possibleKingMoves(king: Piece) -> [Position] {
        var coordinates = [Position]()

        coordinates += appendKingRookLikeMoves(king: king, upOrlower: true, fileOrRank: false)
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: false, fileOrRank: false)
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: false, fileOrRank: true)
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: true, fileOrRank: true)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: true, fileOrRank: false)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: false, fileOrRank: false)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: false, fileOrRank: true)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: true, fileOrRank: true)
        
        return coordinates
    }
}
