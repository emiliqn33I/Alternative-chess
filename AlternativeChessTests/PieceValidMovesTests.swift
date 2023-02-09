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
        XCTAssertTrue(validMoves.contains(Position(file: .D, rank: .sixth)))
        
        chessEngine.place(piece: pieces[0], at: Position(file: .D, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(pieces[0].position == Position(file: .D, rank: .sixth))
        XCTAssertNil((pieces.first { $0.position == Position(file: .D, rank: .fifth)}))
    }
    
    func testPawnEnPassantBlackRightDiagonal() {
        // Given the user has a black pawn at E4 and white pawn at F2, and king at E8 for validating moves
        var pieces = [Piece(type: .pawn, colour: .black, position: Position(file: .E, rank: .fourth)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .F, rank: .second)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: true)
        // And the white have moved pawn form F2 to F4
        chessEngine.place(piece: pieces[1], at: Position(file: .F, rank: .fourth))
        // And it's turn to the user(as black) to move
        if chessEngine.turn != false {
            XCTFail()
        }
        // And the last move of the black pieces was a pawn at F2 to F4
        if chessEngine.history.last! != (Position(file: .F, rank: .second), Position(file: .F, rank: .fourth)) {
            XCTFail()
        }
        // Then the user will be able to take the pawn at F4 while moveing to F3 with the black pawn, and the pawn at F4 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .third)))
        
        chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .third))
        pieces = chessEngine.pieces
        XCTAssertTrue(pieces[0].position == Position(file: .F, rank: .third))
        XCTAssertNil((pieces.first { $0.position == Position(file: .F, rank: .fourth)}))
    }
    
    func testPawnEnPassantBlackLeftDiagonal() {
        // Given the user has a black pawn at E4 and white pawn at D2, and king at E8 for validating moves
        var pieces = [Piece(type: .pawn, colour: .black, position: Position(file: .E, rank: .fourth)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .second)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: true)
        // And the white have moved pawn form D2 to D4
        chessEngine.place(piece: pieces[1], at: Position(file: .D, rank: .fourth))
        // And it's turn to the user(as black) to move
        if chessEngine.turn != false {
            XCTFail()
        }
        // And the last move of the black pieces was a pawn at D2 to D4
        if chessEngine.history.last! != (Position(file: .D, rank: .second), Position(file: .D, rank: .fourth)) {
            XCTFail()
        }
        // Then the user will be able to take the pawn at D4 while moveing to D3 with the black pawn, and the pawn at D4 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .D, rank: .third)))
        
        chessEngine.place(piece: pieces[0], at: Position(file: .D, rank: .third))
        pieces = chessEngine.pieces
        XCTAssertTrue(pieces[0].position == Position(file: .D, rank: .third))
        XCTAssertNil((pieces.first { $0.position == Position(file: .D, rank: .fourth)}))
    }
    
    func testPieceValidMovesTests2() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .bishop, colour: .black, position: Position(file: .C, rank: .fourth)),
                      Piece(type: .queen, colour: .black, position: Position(file: .E, rank: .second)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: false)
        // When the user places choses a pawn at D2(that defence the king from checks, from the queen at B4).
        // Then the pawn won't have any valid moves
        let validMoves = chessEngine.validMoves(for: pieces[0])
        print(validMoves)

        XCTAssertTrue(validMoves.isEmpty)
    }
    
    func testCheckMate() {
        // Given the user has a white king at E1 and black queen at E2, and black bishop at C4, and black king for validating moves
        let pieces = [Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .bishop, colour: .black, position: Position(file: .C, rank: .fourth)),
                      Piece(type: .queen, colour: .black, position: Position(file: .E, rank: .second)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: true)
        // And there are no pieces that can take the queen
        XCTAssertTrue(chessEngine.validMovesDefendingKing(king: pieces[0]).isEmpty)
        // Then the black king will be checkMated, and white wins
        XCTAssertTrue(chessEngine.validMoves(for: pieces[0]).isEmpty)
        XCTAssertTrue(chessEngine.checkMate == true)
        XCTAssertTrue(chessEngine.winner == true)
    }
    
    func testRokadoWhiteKingSide() {
        // Given the user has a white king at E1 and white rook at H1
        let pieces = [Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: true)
        // And there are no pieces that are attacking the king between the rook
        // Then the white king can castle kingside and will have G1 as a valid move
        XCTAssertTrue(chessEngine.validMoves(for: pieces[0]).contains(Position(file: .G, rank: .first)))
        chessEngine.place(piece: pieces[0], at: Position(file: .G, rank: .first))
        //And the rook will be at F1
        XCTAssertTrue(chessEngine.pieces.contains(Piece(type: .rook, colour: .white, position: Position(file: .F, rank: .first))))
    }
}
