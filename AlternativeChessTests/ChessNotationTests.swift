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
        let pieces = [Piece(.pawn, .white, Position(file: .G, rank: .seventh)),
                      Piece(.king, .white, Position(file: .F, rank: .first)),
                      Piece(.rook, .white, Position(file: .E, rank: .seventh)),
                      Piece(.knight, .white, Position(file: .D, rank: .first)),
                      Piece(.bishop, .white, Position(file: .C, rank: .seventh)),
                      Piece(.queen, .white, Position(file: .A, rank: .first)),
                      Piece(.duck, .yellow, Position(file: .B, rank: .seventh)) ]
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
