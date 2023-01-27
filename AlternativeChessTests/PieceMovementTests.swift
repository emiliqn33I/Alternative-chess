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
        if pawnA2.isEmpty {
            XCTFail()
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

    func testWhiteRookMovesStartingPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a pawn at the H1
        let rookH1 = allpieces.first { $0.position.rank == .first && $0.position.file == .H }
        if rookH1 == nil {
            XCTFail()
        }
        // And there is no piece upper from the rook at H1
        let piecesOnHFile = allpieces.filter { $0.position.file == .H && $0.position.rank.rawValue > 0 }
        
        if piecesOnHFile.count != 0 {
            XCTFail()
        }
        // And there is no piece left from the rook at H1
        let piecesOnARank = allpieces.filter { $0.position.rank == .first && $0.position.file.rawValue < 7 }
        
        if piecesOnARank.count != 0 {
            XCTFail()
        }
        // When they tap the rook H1
        // Then the H2, H3, H4, H5, H6, H7, H8, G1, F1, E1, D1, C1, B1, A1  squares on the board will be highlighted
        let validMovesH1 = chessEngine.possibleMoves(piece: rookH1!)
        XCTAssert(validMovesH1.count == 14)
        XCTAssert((validMovesH1[0].file == .H) && (validMovesH1[0].rank == .second) &&
                  (validMovesH1[1].file == .H) && (validMovesH1[1].rank == .third) &&
                  (validMovesH1[2].file == .H) && (validMovesH1[2].rank == .fourth) &&
                  (validMovesH1[3].file == .H) && (validMovesH1[3].rank == .fifth) &&
                  (validMovesH1[4].file == .H) && (validMovesH1[4].rank == .sixth) &&
                  (validMovesH1[5].file == .H) && (validMovesH1[5].rank == .seventh) &&
                  (validMovesH1[6].file == .H) && (validMovesH1[6].rank == .eighth) &&
                  (validMovesH1[7].file == .G) && (validMovesH1[7].rank == .first) &&
                  (validMovesH1[8].file == .F) && (validMovesH1[8].rank == .first) &&
                  (validMovesH1[9].file == .E) && (validMovesH1[9].rank == .first) &&
                  (validMovesH1[10].file == .D) && (validMovesH1[10].rank == .first) &&
                  (validMovesH1[11].file == .C) && (validMovesH1[11].rank == .first) &&
                  (validMovesH1[12].file == .B) && (validMovesH1[12].rank == .first) &&
                  (validMovesH1[13].file == .A) && (validMovesH1[13].rank == .first))
    }
    
    func testWhiteRookMovesRandomPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        
        // And there is a rook at the E4
        let rookE4 = allpieces.first { $0.position.rank == .fourth && $0.position.file == .E }
        if rookE4 == nil {
            XCTFail()
        }
        
        // And there is no piece on E file other than the rook
        let piecesOnEFile = allpieces.filter { $0.position.file == .E }

        if (piecesOnEFile.count != 1) || (piecesOnEFile[0].type != .rook) {
            XCTFail()
        }
        // And there is no piece on the third rank other than the rook
        let piecesOn4Rank = allpieces.filter { $0.position.rank == .fourth }

        if (piecesOn4Rank.count != 1) || (piecesOn4Rank[0].type != .rook) {
            XCTFail()
        }
        
        // When they tap the rook E3
        // Then the E4, E5, E6, E7, E8, E2, E1, D3, C3, B3, A3, F3, G3, H3 squares on the board will be highlighted
        let validMovesE4 = chessEngine.possibleMoves(piece: rookE4!)
        XCTAssert(validMovesE4.count == 14)
        XCTAssert((validMovesE4[0].file == .E) && (validMovesE4[0].rank == .fifth) &&
                  (validMovesE4[1].file == .E) && (validMovesE4[1].rank == .sixth) &&
                  (validMovesE4[2].file == .E) && (validMovesE4[2].rank == .seventh) &&
                  (validMovesE4[3].file == .E) && (validMovesE4[3].rank == .eighth) &&
                  (validMovesE4[4].file == .E) && (validMovesE4[4].rank == .third) &&
                  (validMovesE4[5].file == .E) && (validMovesE4[5].rank == .second) &&
                  (validMovesE4[6].file == .E) && (validMovesE4[6].rank == .first) &&
                  (validMovesE4[7].file == .D) && (validMovesE4[7].rank == .fourth) &&
                  (validMovesE4[8].file == .C) && (validMovesE4[8].rank == .fourth) &&
                  (validMovesE4[9].file == .B) && (validMovesE4[9].rank == .fourth) &&
                  (validMovesE4[10].file == .A) && (validMovesE4[10].rank == .fourth) &&
                  (validMovesE4[11].file == .F) && (validMovesE4[11].rank == .fourth) &&
                  (validMovesE4[12].file == .G) && (validMovesE4[12].rank == .fourth) &&
                  (validMovesE4[13].file == .H) && (validMovesE4[13].rank == .fourth))
    }
}
