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
        let blackPawn = Piece(.pawn, .black, Position(file: .A, rank: .seventh))
        let pieces = [Piece(.pawn, .white, Position(file: .F, rank: .seventh)),
                      blackPawn,
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .black)
        
        let validMovesForBlackPawn = chessEngine.validMoves(for: blackPawn)

        XCTAssertTrue(validMovesForBlackPawn.count == 0, "Expected 0 got: \(validMovesForBlackPawn.count)")
    }
    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
