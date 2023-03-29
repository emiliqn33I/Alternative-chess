//
//  Move.swift
//  AlternativeChess
//
//  Created by emo on 13.02.23.
//

import Foundation

protocol MoveDelegate: AnyObject {
    func getPiece(at: Position) -> Piece?
    func getHistory() -> [Move]
    func getPieces() -> [Piece]
    func getPossibleMoves(for piece: Piece) -> [Position]
}

struct Move {
    enum MoveType: Equatable {
        case promotion(promoted: Piece)
        case take(taken: Piece)
        case castle(rook: Piece)
        case enPassant(takenPawn: Piece)
        case move
    }
    
    enum KingEffect: Equatable {
        case check(checkedKing: Piece)
        case mate(matedKing: Piece)
    }
    
    let piece: Piece
    let from: Position
    let to: Position
    let type: MoveType
    var kingEffect: KingEffect?
    var notationOfMove: String?
    
    weak var delegate: MoveDelegate?
    
    init(piece: Piece, from: Position, to: Position, type: MoveType = .move, kingEffect: KingEffect? = nil, notationOfMove: String? = nil) {
        self.piece = piece
        self.from = from
        self.to = to
        self.type = type
        self.kingEffect = kingEffect
        self.notationOfMove = notationOfMove
    }
    
    init() {
        self.piece = Piece(.pawn, .white, Position(file: .A, rank: .first))
            self.from = Position(file: .A, rank: .first)
            self.to = Position(file: .A, rank: .second)
            self.type = .move
        }

    func makeMove(notation: String) -> Move? {
        // Determine the move type based on the notation
        var moveType: Move.MoveType = .move
        var pieceFrom: Piece?
        var move: Move
        
        // Make sure the notation is at least two characters long
        guard notation.count >= 2 else {
            return nil
        }

        // Get the from and to positions from the notation
        let fromPosition = giveFromAndTo(notation).0
        let toPosition = giveFromAndTo(notation).1
        
        print(fromPosition, toPosition)
    
        // Get the piece at the from position
        if let delegate = delegate {
            if let pieceFromPosition = delegate.getPiece(at: fromPosition) {
                pieceFrom = pieceFromPosition
            } else {
                return nil
            }
            
            if notation.contains("x") {
                // Taking move
                if let pieceForTaking = delegate.getPiece(at: toPosition) {
                    moveType = .take(taken: pieceForTaking)
                }
            } else if notation.last == "Q" {
                // Pawn promotion move
                //moveType = .promotion(promoted: )
            } else if notation == "O-O" || notation == "O-O-O" {
                // Castle move
                //moveType = .castle(rook:)
            }
        }

        // Create the move object
        if let pieceFrom = pieceFrom {
            move = Move(piece: pieceFrom, from: fromPosition, to: toPosition, type: moveType)
            
            // Add notation if available
            move.notationOfMove = notation
        } else {
            return nil
        }

        return move
    }

    func giveFromAndTo(_ notation: String) -> (Position, Position) {
        var turn: Piece.Color
        var fromFile: Position.File = .A
        var fromRank: Position.Rank = .first
        var toFile: Position.File = .A
        var toRank: Position.Rank = .first
        var fromAndToPositions: (Position, Position) = (Position(file: .A, rank: .first), Position(file: .A, rank: .first))
        let pattern = "[a-z]\\d" // Matches a lowercase letter followed by a digit
        print("hi6")
        if let delegate = delegate {
            print("delegate in")
            if delegate.getHistory().count == 0 {
                return fromAndToPositions
            } else if delegate.getHistory().count % 2 == 0 {
                turn = .black
            } else {
                turn = .white
            }
            print("hi5")
            for type in Piece.PieceType.allCases {
                let stringType = String(describing: type).uppercased()
                print("hi4")
                if stringType.prefix(1) == notation.prefix(1) {
                    let possiblePieces = delegate.getPieces().filter { $0.type == type && $0.colour == turn }
                    print("hi3")
                    if let range = notation.range(of: pattern, options: .regularExpression) {
                        let matchedSubstring = notation[range]
                        let outputIndexFile = notation.index(notation.startIndex, offsetBy: 0) // or use notation.startIndex
                        let matchingCaseFile = Position.File.allCases.first { String(describing: $0).lowercased() == String(notation[outputIndexFile]).lowercased() }
                        let outputIndexRank = notation.index(outputIndexFile, offsetBy: 1)
                        let matchingCaseRank = Position.Rank.allCases.first { $0.rawValue == Int(String(notation[outputIndexRank]))! - 1 }
                        print("hi2")
                        for aPiece in possiblePieces {
                            if
                                let matchingCaseFile = matchingCaseFile,
                                let matchingCaseRank = matchingCaseRank {
                                print("hi")
                                if delegate.getPossibleMoves(for: aPiece).contains(Position(file: matchingCaseFile, rank: matchingCaseRank)) {
                                    toFile = matchingCaseFile
                                    toRank = matchingCaseRank
                                    fromFile = aPiece.position.file
                                    fromRank = aPiece.position.rank
                                }
                            }
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

extension Move: Equatable {
    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.piece == rhs.piece && lhs.from == rhs.from && lhs.to == rhs.to && lhs.type == rhs.type && lhs.kingEffect == rhs.kingEffect && lhs.notationOfMove == rhs.notationOfMove
    }
}
