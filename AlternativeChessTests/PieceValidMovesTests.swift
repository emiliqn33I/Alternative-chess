//
//  PieceValidMovesTests.swift
//  AlternativeChessTests
//
//  Created by emo on 6.02.23.
//

import XCTest
@testable import AlternativeChess

final class PieceValidMovesTests: XCTestCase {

    func createSUT(pieces: [Piece], turn: Bool) -> ChessEngine {
        return ChessEngine(pieces: pieces, turn: turn)
    }
    
    func testPieceValidMovesTests() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .second)),
                      Piece(type: .queen, colour: .black, position: Position(file: .B, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces, turn: true)
        // When the user places choses a pawn at D2(that defence the king from checks, from the queen at B4).
        // Then the pawn won't have any valid moves
        let validMoves = chessEngine.validMoves(for: pieces[1])

        XCTAssertTrue(validMoves.isEmpty)
    }
    
    func testPawnEnPassantWhiteRightDiagonal() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .E, rank: .fifth)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .F, rank: .seventh)),
                      Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: false)
        // And the black have moved pawn form F7 to F5
        chessEngine.place(piece: pieces[1], at: Position(file: .F, rank: .fifth))
        // And it's turn to the user(as white) to move
        if chessEngine.turn != true {
            XCTFail()
        }
        // And the last move of the black pieces was a pawn at F7 to F5
        if chessEngine.history.last! != (Position(file: .F, rank: .seventh), Position(file: .F, rank: .fifth)) {
            XCTFail()
        }
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(pieces[0].position == Position(file: .F, rank: .sixth))
        XCTAssertNil((pieces.first { $0.position == Position(file: .F, rank: .fifth)}))
    }
    
    func testPawnEnPassantWhiteLeftDiagonal() {
        // Given the user has a white pawn at E5 and black pawn at D5, and king at E1 for validating moves
        var pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .E, rank: .fifth)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .D, rank: .seventh)),
                      Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: false)
        // And the black have moved pawn form D7 to D5
        chessEngine.place(piece: pieces[1], at: Position(file: .D, rank: .fifth))
        // And it's turn to the user(as white) to move
        if chessEngine.turn != true {
            XCTFail()
        }
        // And the last move of the black pieces was a pawn at D7 to D5
        if chessEngine.history.last! != (Position(file: .D, rank: .seventh), Position(file: .D, rank: .fifth)) {
            XCTFail()
        }
        // Then the user will be able to take the pawn at D5 while moveing to D6 with the white pawn, and the pawn at D5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        print(validMoves)
        XCTAssertTrue(validMoves.contains(Position(file: .D, rank: .sixth)))
        
        chessEngine.place(piece: pieces[0], at: Position(file: .D, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(pieces[0].position == Position(file: .D, rank: .sixth))
        XCTAssertNil((pieces.first { $0.position == Position(file: .D, rank: .fifth)}))
    }
}
