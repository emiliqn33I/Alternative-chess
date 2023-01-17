//
//  ChessPiece.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//

import Foundation

struct IntWithString: RawRepresentable, Codable, ExpressibleByStringLiteral, Equatable {
    typealias StringLiteralType = String

    let value: Int
    let name: String

    var rawValue: String {
        return "\(value),\(name)"
    }
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: ",")
        guard components.count == 2 else {
            return nil
        }
        self.value = Int(components[0])!
        self.name = components[1]
    }

    init(stringLiteral rawValue: String) {
        self.init(rawValue: rawValue)!
    }
}

struct IntWithInt: RawRepresentable, Codable, ExpressibleByStringLiteral, Equatable {
    typealias StringLiteralType = String

    let value: Int
    let name: Int

    var rawValue: String {
        return "\(value),\(name)"
    }
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: ",")
        guard components.count == 2 else {
            return nil
        }
        self.value = Int(components[0])!
        self.name = Int(components[1])!
    }

    init(stringLiteral rawValue: String) {
        self.init(rawValue: rawValue)!
    }
}

struct Piece {
    enum Rank: IntWithInt {
        case first = "7,1" // One value communicates with the user(1) and the other with the array of pieces(7),
        case second = "6,2"
        case third = "5,3"
        case fourth = "4,4"
        case fifth = "3,5"
        case sixth = "2,6"
        case seventh = "1,7"
        case eighth = "0,8"
        
        var value: Int { return rawValue.value }
        var name: Int { return rawValue.name }
    }
    enum File: IntWithString {
        case A = "0,A" // One value communicates with the user(A) and the other with the array of pieces(0),
        case B = "1,B"
        case C = "2,C"
        case D = "3,D"
        case E = "4,E"
        case F = "5,F"
        case G = "6,G"
        case H = "7,H"
        
        var value: Int { return rawValue.value }
        var name: String { return rawValue.name }
    }
    enum PieceType {
        case pawn
        case none // Case for square without a piece. Needed for initialising empty square.
    }
    enum Color {
        case white
        case black
        case none // Case for square without a piece. Needed for initialising empty square.
    }
    var file: File
    var rank: Rank
    var type: PieceType
    var colour: Color
    
    init(type: PieceType, colour: Color, file: File, rank: Rank) {
        self.type = type
        self.colour = colour
        self.file = file
        self.rank = rank
    }
}
