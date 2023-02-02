//
//  PieceTakeTests.swift
//  AlternativeChessTests
//
//  Created by emo on 2.02.23.
//

import XCTest
@testable import AlternativeChess

final class PieceTakeTests: XCTestCase {

    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces)
    }

    func testWhitePawnTakes() {
        // Given the user is on the board screen
        // And there is white pawn at B2 and black pawns at B3 and A3
        let pieces = [Piece(type: .pawn, colour: .black, position: Position(file: .C, rank: .third)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .second)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .A, rank: .third))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the B2 pawn
        // Then the C3 and A3 will be highlighted
        let validMovesB2pawn = chessEngine.possibleMoves(piece: pieces[1])
        print(validMovesB2pawn)
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .C, rank: .third)))
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .A, rank: .third)))
    }
}
