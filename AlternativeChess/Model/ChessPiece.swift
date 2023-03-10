//
//  ChessPiece.swift
//  AlternativeChess
//
//  Created by emo on 15.01.23.
//
import Foundation

struct Position {
    enum Rank: Int, CaseIterable {
        case first
        case second
        case third
        case fourth
        case fifth
        case sixth
        case seventh
        case eighth

        func changed(with delta: Int) -> Rank {
            return Rank(rawValue: rawValue + delta) ?? .first
        }
    }

    enum File: Int , CaseIterable{
        case A
        case B
        case C
        case D
        case E
        case F
        case G
        case H

        func changed(with delta: Int) -> File {
            return File(rawValue: rawValue + delta) ?? .A
        }
    }

    let file: File
    let rank: Rank

    init(file: File, rank: Rank) {
        self.file = file
        self.rank = rank
    }

    func changedFile(delta: Int) -> Position {
        return Position(file: file.changed(with: delta), rank: rank)
    }

    func changedRank(delta: Int) -> Position {
        return Position(file: file, rank: rank.changed(with: delta))
    }

    func changed(fileDelta: Int, rankDelta: Int) -> Position {
        return Position(file: file.changed(with: fileDelta), rank: rank.changed(with: rankDelta))
    }
}

extension Position: Equatable {
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.file == rhs.file && lhs.rank == rhs.rank
    }
}

extension Position: CustomStringConvertible {
    var description: String {
        "(\(file)\(rank))"
    }
}

class Piece {
    enum PieceType {
        case pawn
        case rook
        case bishop
        case knight
        case queen
        case king
        case duck
    }

    enum Color {
        case white
        case black
        case yellow
    }

    var position: Position
    var type: PieceType
    var colour: Color

    init(_ type: PieceType, _ colour: Color, _ position: Position) {
        self.type = type
        self.colour = colour
        self.position = position
    }

    var imageName: String {
        switch type {
        case .pawn:
            return colour == .white ? "w_pawn" : "b_pawn"
        case .rook:
            return colour == .white ? "w_rook" : "b_rook"
        case .bishop:
            return colour == .white ? "w_bishop" : "b_bishop"
        case .knight:
            return colour == .white ? "w_knight" : "b_knight"
        case .queen:
            return colour == .white ? "w_queen" : "b_queen"
        case .king:
            return colour == .white ? "w_king" : "b_king"
        case .duck:
            return "fposter,small,wall_texture,product,750x1000"
        }
    }
}

extension Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.position == rhs.position && lhs.type == rhs.type && lhs.colour == rhs.colour
    }
}

extension Piece: CustomStringConvertible {
    var description: String {
        "(\(type), \(colour), \(position))"
    }
}
