//
//  Move.swift
//  AlternativeChess
//
//  Created by emo on 13.02.23.
//

import Foundation

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
        case doubleCheck(checkedKing: Piece)
    }
    
    let piece: Piece
    let from: Position
    let to: Position
    let type: MoveType
    var kingEffect: KingEffect?
    var disambiguas: Character?
    
    init(piece: Piece, from: Position, type: MoveType = .move, kingEffect: KingEffect? = nil, disambiguas: Character?) {
        self.piece = piece
        self.from = from
        self.to = piece.position
        self.type = type
        self.kingEffect = kingEffect
        self.disambiguas = disambiguas
    }
    
    func makeNotation() -> String? {
        var notationOfMove: String?
        
        switch type {
        case .take(_):
                if piece.type == .pawn {
                    if let _ = String(describing:piece.type).first {
                        notationOfMove = "\(from.file.notation)x\(to.notation)"
                    }
                } else {
                    if disambiguas == "r" {
                        if let pieceType = String(describing:piece.type).first {
                            notationOfMove = "\(pieceType.uppercased())\(from.file.notation)x\(to.notation)"
                        }
                    } else if disambiguas == "f" {
                        if let pieceType = String(describing:piece.type).first {
                            notationOfMove = "\(pieceType.uppercased())\(from.rank.notation)x\(to.notation)"
                        }
                    } else {
                        if let pieceType = String(describing:piece.type).first {
                            notationOfMove = "\(pieceType.uppercased())x\(to.notation)"
                        }
                    }
                }
            break
        case .promotion(_):
            notationOfMove = "\(to.notation)Q"
            break
        case .castle(_):
            notationOfMove = piece.position.file == .G ? "O-O" : "O-O-O"
            break
        case .enPassant(_):
            notationOfMove = "\(from.file.notation)x\(to.notation)"
            break
        case .move:
            if piece.type == .pawn {
                if let _ = String(describing:piece.type).first {
                    notationOfMove = "\(to.notation)"
                }
            } else {
                if disambiguas == "r" {
                    if let pieceType = String(describing:piece.type).first {
                        notationOfMove = "\(pieceType.uppercased())\(from.file.notation)\(to.notation)"
                    }
                } else if disambiguas == "f" {
                    if let pieceType = String(describing:piece.type).first {
                        notationOfMove = "\(pieceType.uppercased())\(from.rank.notation)\(to.notation)"
                    }
                } else {
                    if let pieceType = String(describing:piece.type).first {
                        notationOfMove = "\(pieceType.uppercased())\(to.notation)"
                    }
                }
            }
        }
        if notationOfMove != nil {
            switch kingEffect {
            case .mate(_):
                notationOfMove! += "#"
            case .check(_):
                notationOfMove! += "+"
            case .doubleCheck(_):
                notationOfMove! += "++"
            default:
                break
            }
        }
            
        return notationOfMove
    }
}

extension Move: Equatable {
    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.piece == rhs.piece && lhs.from == rhs.from && lhs.to == rhs.to && lhs.type == rhs.type && lhs.kingEffect == rhs.kingEffect
    }
}
