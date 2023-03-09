//
//  DuckTests.swift
//  AlternativeChessTests
//
//  Created by emo on 6.03.23.
//

import XCTest
@testable import AlternativeChess

final class DuckTests: XCTestCase {
    
    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces, turn: .white)
    }

    func testDuckCantBeTakenByWhite() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .duck, colour: .yellow, position: Position(file: .H, rank: .fourth)),
                      Piece(type: .queen, colour: .white, position: Position(file: .B, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        
        XCTAssertFalse(validMoves.contains(Position(file: .H, rank: .fourth)))
    }
    
    func testDuckCantBeTakenByBlack() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(type: .king, colour: .black, position: Position(file: .E, rank: .first)),
                      Piece(type: .duck, colour: .yellow, position: Position(file: .H, rank: .fourth)),
                      Piece(type: .queen, colour: .black, position: Position(file: .B, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        
        XCTAssertFalse(validMoves.contains(Position(file: .H, rank: .fourth)))
    }
    
    func testDuckPossibleMoves() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(type: .king, colour: .black, position: Position(file: .E, rank: .first)),
                      Piece(type: .duck, colour: .yellow, position: Position(file: .H, rank: .fourth)),
                      Piece(type: .queen, colour: .black, position: Position(file: .B, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        print(validMoves.count)
        
        XCTAssertTrue(validMoves.count == 61)
    }
}
