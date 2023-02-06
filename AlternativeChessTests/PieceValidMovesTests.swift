//
//  PieceValidMovesTests.swift
//  AlternativeChessTests
//
//  Created by emo on 6.02.23.
//

import XCTest
@testable import AlternativeChess

final class PieceValidMovesTests: XCTestCase {

    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces)
    }
    
    func PieceValidMovesTests() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .second)),
                      Piece(type: .queen, colour: .black, position: Position(file: .B, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        // When the user places choses a pawn at D2(that defence the king from checks, from the queen at B4).
        // Then the pawn won't have any valid moves
        let validMoves = chessEngine.validMoves(for: pieces[1])

        XCTAssertTrue(validMoves.isEmpty)
    }
}
