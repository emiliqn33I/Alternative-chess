//
//  InCheckCantMovePieces.swift
//  AlternativeChessTests
//
//  Created by emo on 7.03.23.
//

import XCTest
@testable import AlternativeChess

final class InCheckCantMovePieces: XCTestCase {
    
    func testKingInChecKWithPawn() {
        let blackPawn = Piece(type: .pawn, colour: .black, position: Position(file: .A, rank: .seventh))
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .F, rank: .seventh)),
                      blackPawn,
                      Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .black)
        
        let validMovesForBlackPawn = chessEngine.validMoves(for: blackPawn)

        XCTAssertTrue(validMovesForBlackPawn.count == 0, "Expected 0 got: \(validMovesForBlackPawn.count)")
    }
    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
