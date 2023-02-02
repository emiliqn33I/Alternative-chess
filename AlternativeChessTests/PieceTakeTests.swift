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
        XCTAssertTrue(validMovesB2pawn.count == 4)
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .C, rank: .third)))
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .A, rank: .third)))
    }
    
    func testWhiteRookTakes() {
        // Given the user is on the board screen
        // And there is white rook at D4 and black pawns at B4, D6, D2 and F4
        let pieces = [Piece(type: .pawn, colour: .black, position: Position(file: .D, rank: .sixth)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .B, rank: .fourth)),
                      Piece(type: .rook, colour: .white, position: Position(file: .D, rank: .fourth)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .D, rank: .second)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .F, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the D4 rook
        // Then the B4, D6, D2 and F4 will be highlighted
        let validMovesB2pawn = chessEngine.possibleMoves(piece: pieces[2])
        XCTAssertTrue(validMovesB2pawn.count == 8)
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .D, rank: .sixth)))
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .B, rank: .fourth)))
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .D, rank: .second)))
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .F, rank: .fourth)))
    }
}
