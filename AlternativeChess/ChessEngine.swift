//
//  ChessEngine.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//
import Foundation

class ChessEngine {
    var helper = Helper()
    var pieces: [Piece]
    var history: [Move] = []
    var turn: Piece.Color
    var kingEffect: Move.KingEffect?
    var winner: Piece.Color?
    var enPassantMoves: [Position] = []
    
    init(pieces: [Piece], turn: Piece.Color) {
        self.pieces = pieces
        self.turn = turn
    }
    
    func place(piece: Piece, at position: Position) -> Move {
        let originalPosition = piece.position
        let originalType = piece.type
        let originalColor = piece.colour
        var moveType: Move.MoveType?
        var disambiguas: Character?
        
        if piece.type != .pawn {
            let sameRankPawn = pieces.filter { $0.type == piece.type && $0.colour == piece.colour && $0.position.rank == originalPosition.rank }
            let sameFilePawn = pieces.filter { $0.type == piece.type && $0.colour == piece.colour && $0.position.file == originalPosition.file }
            if sameRankPawn.count > 1 {
                disambiguas = "r"
            } else if sameFilePawn.count > 1 {
                disambiguas = "f"
            } else {
                disambiguas = nil
            }
        }
        
        if let piece = castlePlaceLogic(piece: piece, at: position) {
            moveType = .castle(rook: piece)
        }
        
        if let aPiece = placePieceAtPosition(piece: piece, position: position) {
            if originalType == .pawn && aPiece.type == .queen && aPiece.colour == originalColor {
                moveType = .promotion(promoted: aPiece)
            } else {
                moveType = .take(taken: aPiece)
                // Because of duck piece, king can be taken
                if aPiece.type == .king {
                    kingEffect = .mate(matedKing: aPiece)
                    winner = aPiece.colour
                }
            }
        }
        
        if let piece = removeLogicEnPassant(position: position, piece: piece) {
            moveType = .enPassant(takenPawn: piece)
        }
        
        if let king = king(color: piece.colour == .white ? .black : .white) {
            let sameColorPieces = pieces.filter { $0.colour == piece.colour }
            var counter = 0
            for sameColorPiece in sameColorPieces {
                if possibleMoves(piece: sameColorPiece).contains(king.position) {
                    counter += 1
                    if counter == 1 {
                        kingEffect = .check(checkedKing: king)
                    }
                    if counter == 2 {
                        kingEffect = .doubleCheck(checkedKing: king)
                    }
                }
            }
        }
        
        if isCheckMated(piece: piece) {
            if let matedKing = getKing(ofOppositeColor: piece.colour) {
                kingEffect = .mate(matedKing: matedKing)
            }
        }
        if piece.colour != .yellow {
            turn = helper.reverse(colour: turn)
        }
        let move = Move(piece: piece, from: originalPosition, type: moveType ?? .move, kingEffect: kingEffect, disambiguas: disambiguas)
        if piece.colour != .yellow {
            history.append(move)
        }
        
        return move
    }
    
    func isPromotingPawn(for piece: Piece, and position: Position) -> Bool {
        guard piece.type == .pawn else {
            return false
        }
        let whitePawnPromotion = piece.colour == .white && position.rank == .eighth
        let blackPawnPromotion = piece.colour == .black && position.rank == .first
        return whitePawnPromotion || blackPawnPromotion
    }
    
    func validMoves(for piece: Piece) -> [Position] {
        let possibleMoves = possibleMoves(piece: piece)
        let kingCheckMoves = kingCheckMoves(for: possibleMoves, piece: piece)
        var validMoves = [Position]()
        validMoves = helper.validatingMoves(possibleMoves: possibleMoves, kingCheckMoves: kingCheckMoves)
        validMoves = removeValidMoveForCastle(piece: piece, validMovess: validMoves)
        
        return validMoves
    }
    
    // MARK: Place methods
    private func placeRookWhenCastle(position: Position, kingsideOrQueenside: Bool) -> Piece? {
        var rook: Piece?
        
        for aPiece in pieces {
            if aPiece.position == position && aPiece.type == .rook {
                if let index = pieces.firstIndex(of: aPiece) {
                    if kingsideOrQueenside {
                        pieces[index].position = Position(file: .F, rank: position.rank)
                        rook = pieces[index]
                    } else {
                        pieces[index].position = Position(file: .D, rank: position.rank)
                        rook = pieces[index]
                    }
                }
            }
        }
        return rook
    }
    
    func placePieceAtPosition(piece: Piece, position: Position) -> Piece? {
        var affectedPiece: Piece?
        
        if self.piece(at: position) == nil && isPromotingPawn(for: piece, and: position) == false {
            piece.position = position
        } else if isPromotingPawn(for: piece, and: position) {
            affectedPiece = piece
            affectedPiece?.type = .queen
            affectedPiece?.position = position
        } else {
            let takablePiece = pieces.first { $0 == self.piece(at: position) }
            affectedPiece = takablePiece
            
            if let index = pieces.firstIndex(of: takablePiece!) {
                pieces.remove(at: index)
            }
            piece.position = position
        }
        return affectedPiece
    }
    
    func castlePlaceLogic(piece: Piece, at position: Position) -> Piece? {
        var affectedPiece: Piece?
        let checkIfWhiteKingDidntMoved = history.first { $0.from == Position(file: .E, rank: .first) } == nil
        let checkIfBlackKingDidntMoved = history.first { $0.from == Position(file: .E, rank: .eighth) } == nil
        let checkIfWhiteRookAtH1DidntMoved = history.first { $0.from == Position(file: .H, rank: .first) } == nil
        let checkIfWhiteRookAtA1DidntMoved = history.first { $0.from == Position(file: .A, rank: .first) } == nil
        let checkIfBlackRookAtH8DidntMoved = history.first { $0.from == Position(file: .H, rank: .eighth) } == nil
        let checkIfBlackRookAtA8DidntMoved = history.first { $0.from == Position(file: .A, rank: .eighth) } == nil
        
        
        if piece.type == .king && checkIfWhiteKingDidntMoved && checkIfWhiteRookAtH1DidntMoved && position == Position(file: .G, rank: .first) {
            affectedPiece = placeRookWhenCastle(position: Position(file: .H, rank: .first), kingsideOrQueenside: true)
        }
        if piece.type == .king && checkIfWhiteKingDidntMoved && checkIfWhiteRookAtA1DidntMoved && position == Position(file: .C, rank: .first) {
            affectedPiece = placeRookWhenCastle(position: Position(file: .A, rank: .first), kingsideOrQueenside: false)
        }
        if piece.type == .king && checkIfBlackKingDidntMoved && checkIfBlackRookAtH8DidntMoved && position == Position(file: .G, rank: .eighth) {
            affectedPiece = placeRookWhenCastle(position: Position(file: .H, rank: .eighth), kingsideOrQueenside: true)
        }
        if piece.type == .king && checkIfBlackKingDidntMoved && checkIfBlackRookAtA8DidntMoved && position == Position(file: .C, rank: .eighth) {
            affectedPiece = placeRookWhenCastle(position: Position(file: .A, rank: .eighth), kingsideOrQueenside: false)
        }
        return affectedPiece
    }
    
    // MARK: CheckMate methods
    func checkMateLogic(piece: Piece, colour: Piece.Color) -> Bool {
        let kingOpositeColour = king(color: colour)!
        var flag = false
        
        if validMoves(for: kingOpositeColour).isEmpty && validMovesDefendingKing(king: kingOpositeColour).isEmpty {
            kingEffect = .mate(matedKing: kingOpositeColour)
            flag = true
            if piece.colour == .white {
                winner = .white
            } else {
                winner = .black
            }
        }
        return flag
    }
    
    func isCheckMated(piece: Piece) -> Bool {
        if piece.colour == .white && king(color: .black) != nil {
            if checkMateLogic(piece: piece, colour: .black) {
                return true
            }
            
        }
        if piece.colour == .black && king(color: .white) != nil {
            if checkMateLogic(piece: piece, colour: .white) {
                return true
            }
        }
        return false
    }
    
    // MARK: Remove methods
    func removeLogicEnPassant(position: Position, piece: Piece) -> Piece? {
        var affectedPawn: Piece?
        
        if enPassantMoves.contains(position) && piece.type == .pawn {
            if turn == .white {
                affectedPawn = removeTakenPawnByEnPassant(piece: piece, at: position, changeRankWith: -1)
            }
            if turn == .black {
                affectedPawn = removeTakenPawnByEnPassant(piece: piece, at: position, changeRankWith: 1)
            }
        }
        return affectedPawn
    }
    
    func removeTakenPawnByEnPassant(piece: Piece, at position: Position, changeRankWith: Int) -> Piece? {
        let takablePawnFromEnPassant = pieces.filter { $0.position == Position(file: position.file, rank: position.rank.changed(with: changeRankWith))}
        if takablePawnFromEnPassant.count != 0 {
            if (takablePawnFromEnPassant[0].colour != piece.colour) && (takablePawnFromEnPassant[0].type == .pawn) {
                if let index = pieces.firstIndex(of: takablePawnFromEnPassant[0]) {
                    let removedPawn = pieces[index]
                    pieces.remove(at: index)
                    enPassantMoves.removeAll()
                    return removedPawn
                }
            }
        }
        return nil
    }
    
    func removeValidMoveForCastle(piece: Piece, validMovess: [Position]) -> [Position] {
        var validMoves = validMovess
        
        if piece.type == .king && piece.colour == .white {
            if validMoves.contains(Position(file: .G, rank: .first)) && (validMoves.contains(Position(file: .F, rank: .first)) == false) {
                validMoves = helper.removePositionFromValidMoves(validMoves: validMoves, position: Position(file: .G, rank: .first))
            }
            if validMoves.contains(Position(file: .C, rank: .first)) && (validMoves.contains(Position(file: .D, rank: .first)) == false) {
                validMoves = helper.removePositionFromValidMoves(validMoves: validMoves, position: Position(file: .C, rank: .first))
            }
        }
        if piece.type == .king && piece.colour == .black {
            if validMoves.contains(Position(file: .G, rank: .eighth)) && (validMoves.contains(Position(file: .F, rank: .eighth)) == false) {
                validMoves = helper.removePositionFromValidMoves(validMoves: validMoves, position: Position(file: .G, rank: .eighth))
            }
            if validMoves.contains(Position(file: .C, rank: .eighth)) && (validMoves.contains(Position(file: .D, rank: .eighth)) == false) {
                validMoves = helper.removePositionFromValidMoves(validMoves: validMoves, position: Position(file: .C, rank: .eighth))
            }
        }
        return validMoves
    }
    
    // MARK: King methods
    func king(color: Piece.Color) -> Piece? {
        pieces.first { $0.type == .king && color == $0.colour }
    }
    
    func getKing(ofOppositeColor color: Piece.Color) -> Piece? {
        return pieces.first { $0.type == .king && $0.colour != color }
    }
    
    func kingCheckMoves(for possibleMoves: [Position], piece: Piece) -> [Position] {
        var checkPositions = [Position]()
        let king = king(color: piece.colour)
        if let king = king {
            for move in possibleMoves {
                if isKingInCheck(king: king, at: move, piece: piece) {
                    checkPositions.append(move)
                }
            }
        }
        return checkPositions
    }
    func kingInCheck(piece: Piece, position: Position) -> Move {
        var move = Move(piece: piece, from: position, type: .move, kingEffect: kingEffect, disambiguas: nil)
        
        if let king = king(color: piece.colour) {
            if isKingInCheck(king: king, at: position, piece: piece) {
                move.kingEffect = .check(checkedKing: king)
                return move
            }
        }
        
        return move
    }
    
    func isKingInCheck(king: Piece, at position: Position, piece: Piece) -> Bool {
        let originalPiecePosition = piece.position
        let pieceAtPosition = pieces.first { $0.position == position }
        if let pieceAtPosition = pieceAtPosition {
            if let index = pieces.firstIndex(of: pieceAtPosition) {
                pieces.remove(at: index)
            }
        }
        
        // Update piece position temporarily to check if the king is in check after making the move.
        piece.position = position
        
        defer {
            piece.position = originalPiecePosition
            if let pieceAtPosition = pieceAtPosition {
                pieces.append(pieceAtPosition)
            }
        }
        
        for aPiece in pieces {
            if possibleMoves(piece: aPiece).contains(king.position) {
                return true
            }
        }
        return false
    }
    
    func appendKingRookLikeMoves(king: Piece, upOrlower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()
        
        if iteratingThroughFilesOrRanks(piece: king, upOrLower: upOrlower, fileOrRank: fileOrRank).count != 0 {
            coordinates.append(iteratingThroughFilesOrRanks(piece: king, upOrLower: upOrlower, fileOrRank: fileOrRank)[0])
            
            return coordinates
        }
        
        return coordinates
    }
    
    func appendKingBishopLikeMoves(king: Piece, upOrlower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()
        
        if iteratingThroughFilesAndRanks(piece: king, upOrLower: upOrlower, rightOrLeft: fileOrRank).count != 0 {
            coordinates.append(iteratingThroughFilesAndRanks(piece: king, upOrLower: upOrlower, rightOrLeft: fileOrRank)[0])
            
            return coordinates
        }
        
        return coordinates
    }
    
    func possibleKingMoves(king: Piece) -> [Position] {
        var coordinates = [Position]()
        var checkKingDidNotMoved: Bool
        var checkRookHDidNotMoved: Bool
        var checkRookADidNotMoved: Bool
        var checkNoPieceAtGFile: Bool
        var checkNoPieceAtBFile: Bool
        var checkNoPieceAtFFile: Bool
        var checkNoPieceAtCFile: Bool
        
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: true, fileOrRank: false)
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: false, fileOrRank: false)
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: false, fileOrRank: true)
        coordinates += appendKingRookLikeMoves(king: king, upOrlower: true, fileOrRank: true)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: true, fileOrRank: false)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: false, fileOrRank: false)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: false, fileOrRank: true)
        coordinates += appendKingBishopLikeMoves(king: king, upOrlower: true, fileOrRank: true)
        
        if king.colour == .white {
            checkKingDidNotMoved = history.first { $0.from == Position(file: .E, rank: .first) } == nil
            
            checkRookADidNotMoved = history.first { $0.from == Position(file: .A, rank: .first) } == nil
            
            checkRookHDidNotMoved = history.first { $0.from == Position(file: .H, rank: .first) } == nil
            
            checkNoPieceAtGFile = pieces.first { $0.position == Position(file: .G, rank: .first) } == nil
            
            checkNoPieceAtBFile = pieces.first { $0.position == Position(file: .B, rank: .first) } == nil
            
            checkNoPieceAtCFile = pieces.first { $0.position == Position(file: .C, rank: .first) } == nil
            
            checkNoPieceAtFFile = pieces.first { $0.position == Position(file: .F, rank: .first) } == nil
        } else {
            checkKingDidNotMoved = history.first { $0.from == Position(file: .E, rank: .eighth) } == nil
            
            checkRookADidNotMoved = history.first { $0.from == Position(file: .A, rank: .eighth) } == nil
            
            checkRookHDidNotMoved = history.first { $0.from == Position(file: .H, rank: .eighth) } == nil
            
            checkNoPieceAtGFile = pieces.first { $0.position == Position(file: .G, rank: .eighth) } == nil
            
            checkNoPieceAtBFile = pieces.first { $0.position == Position(file: .B, rank: .eighth) } == nil
            
            checkNoPieceAtCFile = pieces.first { $0.position == Position(file: .C, rank: .eighth) } == nil
            
            checkNoPieceAtFFile = pieces.first { $0.position == Position(file: .F, rank: .eighth) } == nil
        }
        
        //If the kings and the rooks are at right place for castle and the king hasn't move than its appending castle move
        if king.colour == .white && king.position == Position(file: .E, rank: .first) && (pieces.first { $0.type == .rook && $0.position == Position(file: .H, rank: .first)} != nil) && checkKingDidNotMoved && checkRookHDidNotMoved && checkNoPieceAtFFile && checkNoPieceAtGFile {
            coordinates.append(Position(file: .G, rank: .first))
        }
        if king.colour == .black && king.position == Position(file: .E, rank: .eighth) && (pieces.first { $0.type == .rook && $0.position == Position(file: .H, rank: .eighth)} != nil) && checkKingDidNotMoved && checkRookHDidNotMoved && checkNoPieceAtFFile && checkNoPieceAtGFile {
            coordinates.append(Position(file: .G, rank: .eighth))
        }
        if king.colour == .white && king.position == Position(file: .E, rank: .first) && (pieces.first { $0.type == .rook && $0.position == Position(file: .A, rank: .first)} != nil) && checkKingDidNotMoved && checkRookADidNotMoved && checkNoPieceAtBFile && checkNoPieceAtCFile {
            coordinates.append(Position(file: .C, rank: .first))
        }
        if king.colour == .black && king.position == Position(file: .E, rank: .eighth) && (pieces.first { $0.type == .rook && $0.position == Position(file: .A, rank: .eighth)} != nil) && checkKingDidNotMoved && checkRookADidNotMoved && checkNoPieceAtBFile && checkNoPieceAtCFile {
            coordinates.append(Position(file: .C, rank: .eighth))
        }
        
        return coordinates
    }
    
    // MARK: Pawn methods
    func enPassantLogic(pawn: Piece, changeFileWith: Int, changeRankWith: Int, enPassantlastRank: Int) -> [Position] {
        var coordinates = [Position]()
        let enPassantPawn = piece(at: Position(file: pawn.position.file.changed(with: changeFileWith), rank: pawn.position.rank))
        let enPassantPawnLastPosition = history.last?.from
        let enPassantPawnCurrentPosition = history.last?.to
        let ifLastPositionIsRight = (enPassantPawnLastPosition == changedPositionFileAndRank(for: pawn, fileDelta: changeFileWith, rankDelta: enPassantlastRank))
        let ifCurrentPositionIsRight = (enPassantPawnCurrentPosition == Position(file: pawn.position.file.changed(with: changeFileWith), rank: pawn.position.rank))
        
        if ifLastPositionIsRight && ifCurrentPositionIsRight && enPassantPawn?.type == .pawn && enPassantPawn?.colour != pawn.colour {
            coordinates.append(changedPositionFileAndRank(for: pawn, fileDelta: changeFileWith, rankDelta: changeRankWith)!)
            enPassantMoves.append(changedPositionFileAndRank(for: pawn, fileDelta: changeFileWith, rankDelta: changeRankWith)!)
        }
        
        return coordinates
    }
    
    func possiblePawnMoves(pawn: Piece) -> [Position] {
        var coordinates = [Position]()
        
        if pawn.colour == .white {
            // If the pawn is at the second rank then she is able to move to the fourth rank.
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
            // If there is takable piece for the pawn, then the coordinates will be appended.
            if pawn.position.file == .A {
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: 1, incrementWithRank: 1)
            } else if pawn.position.file == .H {
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: -1, incrementWithRank: 1)
            } else {
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: -1, incrementWithRank: 1)
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: 1, incrementWithRank: 1)
            }
            
            if pawn.position.rank == .fifth {
                coordinates += enPassantLogic(pawn: pawn, changeFileWith: 1, changeRankWith: 1, enPassantlastRank: 2)
                coordinates += enPassantLogic(pawn: pawn, changeFileWith: -1, changeRankWith: 1, enPassantlastRank: 2)
            }
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
            
            if pawn.position.file == .A {
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: 1, incrementWithRank: -1)
            } else if pawn.position.file == .H {
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: -1, incrementWithRank: -1)
            } else {
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: -1, incrementWithRank: -1)
                coordinates += appendIfTakablePiece(piece: pawn, incrementWithFile: 1, incrementWithRank: -1)
            }
            
            if pawn.position.rank == .fourth {
                coordinates += enPassantLogic(pawn: pawn, changeFileWith: 1, changeRankWith: -1, enPassantlastRank: -2)
                coordinates += enPassantLogic(pawn: pawn, changeFileWith: -1, changeRankWith: -1, enPassantlastRank: -2)
            }
        }
        
        return coordinates
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
        case .duck:
            return possibleDuckMoves(duck: piece)
        }
    }
    
    func piece(at position: Position) -> Piece? {
        pieces.first { $0.position == position }
    }
    
    func validMovesDefendingKing(king: Piece) -> [Position] {
        var validMovesDefend = [Position]()
        let sameColourAsAttackedKingPieces = pieces.filter { i in
            return i.colour == king.colour
        }
        for i in sameColourAsAttackedKingPieces {
            if i.type != .king {
                validMovesDefend += validMoves(for: i)
            }
        }
        return validMovesDefend
    }
    
    func changedPositionRank(for checkPiece: Piece, delta: Int) -> Position? {
        let positionAtRank = checkPiece.position.changedRank(delta: delta)
        if piece(at: positionAtRank) == nil {
            return positionAtRank
        }
        return nil
    }
    
    func changedPositionFile(for checkPiece: Piece, delta: Int) -> Position? {
        let positionAtFile = checkPiece.position.changedFile(delta: delta)
        if piece(at: positionAtFile) == nil {
            return positionAtFile
        }
        return nil
    }
    
    func changedPositionFileAndRank(for checkPiece: Piece, fileDelta: Int, rankDelta: Int) -> Position? {
        let positionAtFileRank = checkPiece.position.changed(fileDelta: fileDelta, rankDelta: rankDelta)
        if piece(at: positionAtFileRank) == nil {
            return positionAtFileRank
        }
        return nil
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
    
    func appendFileAndRank(piece: Piece, incrementFile: Int, incrementRank: Int) -> [Position] {
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
    
    func iteratingThroughFilesOrRanks(piece: Piece, upOrLower: Bool, fileOrRank: Bool) -> [Position] {
        var coordinates = [Position]()
        
        var incrementWith = helper.upperOrLower(direction: upOrLower)[0]
        let finalFileOrRank = helper.upperOrLower(direction: upOrLower)[1]
        var rookPosition = helper.giveFileOrRank(type: fileOrRank, piece: piece)
        
        while (rookPosition != finalFileOrRank) {
            if helper.checkIsEmpty(positions: appendFileOrRank(fileOrRank: fileOrRank, piece: piece, incrementWith: incrementWith)) {
                if fileOrRank {
                    coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: incrementWith, incrementWithRank: 0)
                } else {
                    coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: 0, incrementWithRank: incrementWith)
                }
                break
            }
            coordinates += appendFileOrRank(fileOrRank: fileOrRank, piece: piece, incrementWith: incrementWith)
            incrementWith = helper.incrementRankOrFile(type: upOrLower, incrementWith: incrementWith, rookPosition: rookPosition)[0]
            rookPosition = helper.incrementRankOrFile(type: upOrLower, incrementWith: incrementWith, rookPosition: rookPosition)[1]
        }
        
        return coordinates
    }
    
    func pieceIsOpositeColorAtThatPosition(piece: Piece, fileBishop: Int, rankBishop: Int) -> Position? {
        let newPos = piece.position.changed(fileDelta: fileBishop, rankDelta: rankBishop)
        let pieceAtThatPos = pieces.filter { $0.position == newPos && $0.colour != piece.colour && $0.colour != .yellow }
        if pieceAtThatPos.count != 0 {
            return newPos
        }
        
        return nil
    }
    
    func iteratingThroughFilesAndRanks(piece: Piece, upOrLower: Bool, rightOrLeft: Bool) -> [Position] {
        var coordinates = [Position]()
        
        var file = helper.giveFileOrRank(type: true, piece: piece)
        var rank = helper.giveFileOrRank(type: false, piece: piece)
        var fileBishop = helper.upperOrLower(direction: rightOrLeft)[0]
        var rankBishop = helper.upperOrLower(direction: upOrLower)[0]
        let finalFile = helper.upperOrLower(direction: rightOrLeft)[1]
        let finalRank = helper.upperOrLower(direction: upOrLower)[1]
        
        while((file != finalFile) && (rank != finalRank)) {
            if helper.checkIsEmpty(positions: appendFileAndRank(piece: piece, incrementFile: fileBishop, incrementRank: rankBishop)) {
                coordinates += appendIfTakablePiece(piece: piece, incrementWithFile: fileBishop, incrementWithRank: rankBishop)
                break
            }
            
            coordinates += appendFileAndRank(piece: piece, incrementFile: fileBishop, incrementRank: rankBishop)
            
            fileBishop = helper.incrementRankAndFile(file: rightOrLeft, rank: upOrLower, incrementFile: fileBishop, incrementRank: rankBishop)[0]
            rankBishop = helper.incrementRankAndFile(file: rightOrLeft, rank: upOrLower, incrementFile: fileBishop, incrementRank: rankBishop)[1]
            file = helper.incrementRankOrFile(type: rightOrLeft, incrementWith: file, rookPosition: 1)[0]
            rank = helper.incrementRankOrFile(type: upOrLower, incrementWith: rank, rookPosition: 1)[0]
        }
        return coordinates
    }
    
    func iteratingThroughFilesAndRanksForKnight(piece: Piece, upOrLower: Bool, rightOrLeft: Bool) -> [Position] {
        var coordinates = [Position]()
        var countFile = 0
        var countRank = 1
        
        for _ in 1...2 {
            var fileKnight = 0
            var rankKnight = 0
            
            fileKnight = helper.incrementRankAndFileKnight(file: rightOrLeft, rank: upOrLower, incrementFile: fileKnight, incrementRank: rankKnight)[countFile]
            
            rankKnight = helper.incrementRankAndFileKnight(file: rightOrLeft, rank: upOrLower, incrementFile: fileKnight, incrementRank: rankKnight)[countRank]
            
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
    
    // MARK: Rook method
    func possibleRookMoves(rook: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: true, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: false, fileOrRank: false)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: false, fileOrRank: true)
        coordinates += iteratingThroughFilesOrRanks(piece: rook, upOrLower: true, fileOrRank: true)
        
        return coordinates
    }
    
    //MARK: Bishop method
    func possibleBishopMoves(bishop: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: true, rightOrLeft: false)
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: true, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: false, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanks(piece: bishop, upOrLower: false, rightOrLeft: false)
        
        return coordinates
    }
    
    //MARK: Knight method
    func possibleKnightMoves(knight: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: true, rightOrLeft: false)
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: true, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: false, rightOrLeft: true)
        coordinates += iteratingThroughFilesAndRanksForKnight(piece: knight, upOrLower: false, rightOrLeft: false)
        
        return coordinates
    }
    
    // MARK: Queen method
    func possibleQueenMoves(queen: Piece) -> [Position] {
        var coordinates = [Position]()
        
        coordinates += possibleRookMoves(rook: queen)
        coordinates += possibleBishopMoves(bishop: queen)
        
        return coordinates
    }
    
    // MARK: Duck method
    func possibleDuckMoves(duck: Piece) -> [Position] {
        var coordinates = [Position]()
        
        for rank in Position.Rank.allCases {
            for file in Position.File.allCases {
                let position = Position(file: file, rank: rank)
                coordinates.append(position)
            }
        }
        
        for position in coordinates {
            for piece in pieces {
                if piece.position == position {
                    if let index = coordinates.firstIndex(of: position) {
                        coordinates.remove(at: index)
                    }
                }
            }
        }
        
        return coordinates
    }
    
    // MARK: Notation to move
    
    func makeMove(from notation: String) -> Move? {
        // Determine the move type based on the notation
        var moveType: Move.MoveType = .move
        var kingEffect: Move.KingEffect?
        var pieceFrom: Piece?
        var move: Move
        
        
        // Make sure the notation is at least two characters long
        guard notation.count >= 2 else {
            return nil
        }
        
        // Get the from and to positions from the notation
        let fromPosition = giveFromAndTo(for: notation).0
        let toPosition = giveFromAndTo(for: notation).1
        
        // Get the piece at the from position
        if let pieceFromPosition = piece(at: fromPosition) {
            pieceFrom = pieceFromPosition
        } else {
            return nil
        }
        
        if notation.contains("x") {
            // Taking move for en passant pawn
            if let firstChar = notation.first, firstChar.isLowercase {
                if piece(at: toPosition) == nil {
                    let rankDelta = (pieceFrom?.colour == .white) ? -1 : 1
                    if
                        let rank = Position.Rank(rawValue: toPosition.rank.rawValue + rankDelta),
                        let pieceForTaking = piece(at: Position(file: toPosition.file, rank: rank)) {
                        moveType = .enPassant(takenPawn: pieceForTaking)
                    }
                }
            }
            // Taking move for piece other than en passant pawn
            if let pieceForTaking = piece(at: toPosition) {
                moveType = .take(taken: pieceForTaking)
            }
        }
        if notation.prefix(1) != "Q" && notation.contains("Q") {
            // Pawn promotion move
            if let pieceFrom = pieceFrom {
                moveType = .promotion(promoted: pieceFrom)
            }
        }
        if notation == "O-O" || notation == "O-O-O" {
            // Castle move
            let file = (notation == "O-O") ? Position.File.H : Position.File.A
            let rank = (pieceFrom?.colour == .white) ? Position.Rank.first : Position.Rank.eighth
            let castleRook = pieces.first {
                $0.type == .rook && $0.colour == pieceFrom?.colour && $0.position == Position(file: file, rank: rank)
            }
            if let castleRook = castleRook {
                moveType = .castle(rook:castleRook)
            }
        }
        if notation.last == "#" {
            // Mate effect
            if let matedKing = getKing(ofOppositeColor: pieceFrom!.colour) {
                kingEffect = .mate(matedKing: matedKing)
            }
        } else if notation.last == "+" {
            // Check effect
            if let checkedKing = getKing(ofOppositeColor: pieceFrom!.colour) {
                kingEffect = .check(checkedKing: checkedKing)
            }
        }
        
        // Create the move object
        if let pieceFrom = pieceFrom {
            move = Move(piece: pieceFrom, from: fromPosition, type: moveType, kingEffect: kingEffect, disambiguas: nil)
        } else {
            return nil
        }
        
        return move
    }
    
    func giveFromAndTo(for notation: String) -> (Position, Position) {
        var turn: Piece.Color
        var fromFile: Position.File = .A
        var fromRank: Position.Rank = .first
        var toFile: Position.File = .A
        var toRank: Position.Rank = .first
        var fromAndToPositions: (Position, Position) = (Position(file: .A, rank: .first), Position(file: .A, rank: .first))
        let pattern = "[a-z]\\d" // Matches a lowercase letter followed by a digit
        let patternFile = "[a-h]"
        let patternRank = "\\d"
        
        if history.count == 0 {
            turn = .white
        } else if history.count % 2 == 0 {
            turn = .white
        } else {
            turn = .black
        }
        if notation == "O-O" || notation == "O-O-O" {
            if notation == "O-O" {
                toFile = .G
                toRank = (turn == .white) ? .first : .eighth
            } else if notation == "O-O-O" {
                toFile = .C
                toRank = (turn == .white) ? .first : .eighth
            }
            fromFile = .E
            fromRank = (turn == .white) ? .first : .eighth
        } else {
            for type in Piece.PieceType.allCases {
                var stringType = String(describing: type).uppercased()
                
                if let firstChar = notation.first {
                    if firstChar.isLowercase && stringType.prefix(1) == "P" {
                        stringType = notation
                    }
                }
                
                if stringType.prefix(1) == notation.prefix(1) {
                    if let range = notation.range(of: pattern, options: .regularExpression) {
                        let matchedSubstring = notation[range]
                        
                        var matchingCaseFile: Position.File = .A
                        var matchingCaseRank: Position.Rank = .first
                        
                        for aFile in Position.File.allCases {
                            let stringFile = String(describing: aFile).lowercased()
                            if stringFile.prefix(1) == matchedSubstring.prefix(1) {
                                matchingCaseFile = aFile
                            }
                        }
                        for aRank in Position.Rank.allCases {
                            let stringRank = String(aRank.rawValue + 1)
                            if stringRank == matchedSubstring.suffix(1) {
                                matchingCaseRank = aRank
                            }
                        }
                        
                        let possiblePieces = pieces.filter { $0.type == type && possibleMoves(piece: $0).contains(Position(file: matchingCaseFile, rank: matchingCaseRank)) && $0.colour == turn }
                        
                        if possiblePieces.count > 1, let range = notation.range(of: pattern, options: .regularExpression) {
                            let extractedString = String(notation[..<range.lowerBound])
                            
                            if let _ = extractedString.range(of: patternFile, options: .regularExpression) {
                                // String contains pattern file
                                for aFile in Position.File.allCases {
                                    let stringFile = String(describing: aFile).lowercased()
                                    if extractedString.contains(String(stringFile.prefix(1))) {
                                        fromFile = aFile
                                        fromRank = possiblePieces[0].position.rank
                                        break
                                    }
                                }
                            } else if let _ = extractedString.range(of: patternRank, options: .regularExpression) {
                                // String contains rank pattern
                                for aRank in Position.Rank.allCases {
                                    let stringRank = String(aRank.rawValue + 1)
                                    if extractedString.contains(String(stringRank)) {
                                        fromFile = possiblePieces[0].position.file
                                        fromRank = aRank
                                        break
                                    }
                                }
                            }
                            toFile = matchingCaseFile
                            toRank = matchingCaseRank
                        } else if possiblePieces.count == 1 {
                            toFile = matchingCaseFile
                            toRank = matchingCaseRank
                            fromFile = possiblePieces[0].position.file
                            fromRank = possiblePieces[0].position.rank
                        }
                    }
                }
            }
        }
        fromAndToPositions.0 = Position(file: fromFile, rank: fromRank)
        fromAndToPositions.1 = Position(file: toFile, rank: toRank)
        
        return fromAndToPositions
    }
}
