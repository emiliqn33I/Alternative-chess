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
    
    func testPieceValidMovesTests() {
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
    
    func testPawnEnPassant() {
        // Given the user has a white pawn at E5 and black pawn at F5
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .E, rank: .fifth)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .F, rank: .fifth))]
        let chessEngine = createSUT(pieces: pieces)
        // And it's his turn to move
        chessEngine.turn = true
        // And the last move of the black pieces was a pawn at F7 to F5
        if chessEngine.history.last != (Position(file: .F, rank: .seventh), Position(file: .F, rank: .fifth)) {
            XCTFail()
        }
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        XCTAssertTrue(pieces[0].position == Position(file: .F, rank: .sixth))
    }
}
