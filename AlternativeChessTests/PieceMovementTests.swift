//
//  PieceMovementTests.swift
//  AlternativeChessTests
//
//  Created by Petar Bel on 26.01.23.
//

import XCTest
@testable import AlternativeChess

final class PieceMovementTests: XCTestCase {
    var chessEngine: ChessEngine!

    override func setUpWithError() throws {
        chessEngine = ChessEngine()
    }

    func testPieceShownOnBoardView() {
        //Then they will see 1 pawns on the 2nd rank
        let piecesOnThe2ndRank = chessEngine.pieces.filter { $0.position.rank == .second }
        XCTAssertTrue(piecesOnThe2ndRank.count == 1)
        
        let _ = piecesOnThe2ndRank.map {
            XCTAssertTrue($0.type == .pawn)
        }
    }

    func testWhitePawnMoves2Squares() {
        // Given the user is on the board screen
        // And there is a pawn at the A2
        let pawnA2 = chessEngine.pieces.filter { $0.position.rank == .second && $0.position.file == .A }
        if (pawnA2.isEmpty) {
            XCTAssert(false)
        }

        // When they tap the pawn A2
        // Then the A3 and A4 squares on the board will be highlighted
        let validMovesA2 = chessEngine.possibleMoves(piece: pawnA2[0])
        XCTAssert((validMovesA2[0].file == .A) && (validMovesA2[0].rank == .third) && (validMovesA2[1].file == .A) && (validMovesA2[1].rank == .fourth))
    }

    func testWhitePawnMoves1Squares() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a pawn at the B3
        let pawnB3 = allpieces.first { $0.position.rank == .third && $0.position.file == .B }
        if pawnB3 == nil {
            XCTFail()
        }
        // And there is no pawn at B4
        let pawnB4 = allpieces.first { $0.position.rank == .fourth && $0.position.file == .B }
        if pawnB4 != nil {
            XCTFail()
        }
        // When they tap the pawn B3
        // Then the B4 squares on the board will be highlighted
        let validMovesB3 = chessEngine.possibleMoves(piece: pawnB3!)
        XCTAssert(validMovesB3.count == 1)
        XCTAssert((validMovesB3[0].file == .B) && (validMovesB3[0].rank == .fourth))
    }

}
