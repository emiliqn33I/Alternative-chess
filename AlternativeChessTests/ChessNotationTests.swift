//
//  ChessNotationTests.swift
//  AlternativeChessTests
//
//  Created by emo on 10.03.23.
//

import XCTest
@testable import AlternativeChess

final class ChessNotationTests: XCTestCase {

    func testChessNotation() {
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .G, rank: .seventh)),
                      Piece(type: .king, colour: .white, position: Position(file: .F, rank: .first)),
                      Piece(type: .rook, colour: .white, position: Position(file: .E, rank: .seventh)),
                      Piece(type: .knight, colour: .white, position: Position(file: .D, rank: .first)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .C, rank: .seventh)),
                      Piece(type: .queen, colour: .white, position: Position(file: .A, rank: .first)),
                      Piece(type: .duck, colour: .yellow, position: Position(file: .B, rank: .seventh)) ]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        
        let notationOfPawn = chessEngine.pieces[0].notation
        XCTAssertTrue(notationOfPawn == "g7")
        
        let notationOfKing = chessEngine.pieces[1].notation
        XCTAssertTrue(notationOfKing == "Kf1")
        
        let notationOfRook = chessEngine.pieces[2].notation
        XCTAssertTrue(notationOfRook == "Re7")
        
        let notationOfKnight = chessEngine.pieces[3].notation
        XCTAssertTrue(notationOfKnight == "Nd1")
        
        let notationOfBishop = chessEngine.pieces[4].notation
        XCTAssertTrue(notationOfBishop == "Bc7")
        
        let notationOfQueen = chessEngine.pieces[5].notation
        XCTAssertTrue(notationOfQueen == "Qa1")
        
        let notationOfDuck = chessEngine.pieces[6].notation
        XCTAssertTrue(notationOfDuck == "Db7")
    }
    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
