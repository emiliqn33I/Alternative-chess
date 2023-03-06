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

    init(type: PieceType, colour: Color, position: Position) {
        self.type = type
        self.colour = colour
        self.position = position
    }
}

extension Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.position.file == rhs.position.file && lhs.position.rank == rhs.position.rank
    }
}
