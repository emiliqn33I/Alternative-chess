//
//  PieceMovementTests.swift
//  AlternativeChessTests
//
//  Created by Petar Bel on 26.01.23.
//

import XCTest
@testable import AlternativeChess

final class PieceMovementTests: XCTestCase {
    func createSUT(piece: Piece) -> ChessEngine {
        return ChessEngine(pieces: [piece])
    }

    func testWhitePawnMoves2Squares() {
        // Given the user is on the board screen
        // And there is a pawn at the A2
        let piece = Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second))
        let chessEngine = createSUT(piece: piece)

        // When they tap the pawn A2
        // Then the A3 and A4 squares on the board will be highlighted
        let validMovesA2 = chessEngine.possibleMoves(piece: piece)
        XCTAssert((validMovesA2[0].file == .A) && (validMovesA2[0].rank == .third) && (validMovesA2[1].file == .A) && (validMovesA2[1].rank == .fourth))
    }

    func testWhitePawnMoves1Squares() {
        // Given the user is on the board screen
        // And there is a pawn at the B3
        let piece = Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .third))
        let chessEngine = createSUT(piece: piece)
        // When they tap the pawn B3
        // Then the B4 squares on the board will be highlighted
        let validMovesB3 = chessEngine.possibleMoves(piece: piece)
        XCTAssert(validMovesB3.count == 1)
        XCTAssert((validMovesB3[0].file == .B) && (validMovesB3[0].rank == .fourth))
    }

    func testWhiteRookMovesStartingPosition() {
        // Given the user is on the board screen
        // And there is a rook at the H1
        let piece = Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the rook at H1
        let validMovesH1 = chessEngine.possibleMoves(piece: piece)
        // When they tap the rook H1
        // Then the H2, H3, H4, H5, H6, H7, H8, G1, F1, E1, D1, C1, B1, A1  squares on the board will be highlighted
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
    
    func testWhiteBishopMovesStartingPosition() {
        // Given the user is on the board screen
        // And there is a bishop at the F1
        let piece = Piece(type: .bishop, colour: .white, position: Position(file: .F, rank: .first))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the bishop at F1
        let validMovesF1 = chessEngine.possibleMoves(piece: piece)
        // When they tap the bishop F1
        // Then the E2, D3, C4, B5, A6, G2, H3  squares on the board will be highlighted
        XCTAssert(validMovesF1.count == 7)
        XCTAssert((validMovesF1[0].file == .E) && (validMovesF1[0].rank == .second) &&
                  (validMovesF1[1].file == .D) && (validMovesF1[1].rank == .third) &&
                  (validMovesF1[2].file == .C) && (validMovesF1[2].rank == .fourth) &&
                  (validMovesF1[3].file == .B) && (validMovesF1[3].rank == .fifth) &&
                  (validMovesF1[4].file == .A) && (validMovesF1[4].rank == .sixth) &&
                  (validMovesF1[5].file == .G) && (validMovesF1[5].rank == .second) &&
                  (validMovesF1[6].file == .H) && (validMovesF1[6].rank == .third))
    }
    
    func testWhiteKnightMovesStartingPosition() {
        // Given the user is on the board screen
        // And there is a knight at the G1
        let piece = Piece(type: .knight, colour: .white, position: Position(file: .G, rank: .first))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the knight at G1
        let validMovesG1 = chessEngine.possibleMoves(piece: piece)
        // When they tap the knight at G1
        // Then the F3, E2, H3 squares on the board will be highlighted
        XCTAssert(validMovesG1.count == 3)
        XCTAssert((validMovesG1[0].file == .F) && (validMovesG1[0].rank == .third) &&
                  (validMovesG1[1].file == .E) && (validMovesG1[1].rank == .second) &&
                  (validMovesG1[2].file == .H) && (validMovesG1[2].rank == .third))
    }
    
    func testWhiteQueenMovesStartingPosition() {
        // Given the user is on the board screen
        // And there is a queen at the D1
        let piece = Piece(type: .queen, colour: .white, position: Position(file: .D, rank: .first))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the queen at D1
        let validMovesD1 = chessEngine.possibleMoves(piece: piece)
        // When they tap the queen at D1
        // Then the D2, D3, D4, D5, D6, D7, D8, E1, F1, G1, H1, C1, B1, A1, E2, F3, G4, H5, C2, B3, A4 squares on the board will be highlighted
        XCTAssert(validMovesD1.count == 21)
        XCTAssert((validMovesD1[0].file == .D) && (validMovesD1[0].rank == .second) &&
                  (validMovesD1[1].file == .D) && (validMovesD1[1].rank == .third) &&
                  (validMovesD1[2].file == .D) && (validMovesD1[2].rank == .fourth) &&
                  (validMovesD1[3].file == .D) && (validMovesD1[3].rank == .fifth) &&
                  (validMovesD1[4].file == .D) && (validMovesD1[4].rank == .sixth) &&
                  (validMovesD1[5].file == .D) && (validMovesD1[5].rank == .seventh) &&
                  (validMovesD1[6].file == .D) && (validMovesD1[6].rank == .eighth) &&
                  (validMovesD1[7].file == .C) && (validMovesD1[7].rank == .first) &&
                  (validMovesD1[8].file == .B) && (validMovesD1[8].rank == .first) &&
                  (validMovesD1[9].file == .A) && (validMovesD1[9].rank == .first) &&
                  (validMovesD1[10].file == .E) && (validMovesD1[10].rank == .first) &&
                  (validMovesD1[11].file == .F) && (validMovesD1[11].rank == .first) &&
                  (validMovesD1[12].file == .G) && (validMovesD1[12].rank == .first) &&
                  (validMovesD1[13].file == .H) && (validMovesD1[13].rank == .first) &&
                  (validMovesD1[14].file == .C) && (validMovesD1[14].rank == .second) &&
                  (validMovesD1[15].file == .B) && (validMovesD1[15].rank == .third) &&
                  (validMovesD1[16].file == .A) && (validMovesD1[16].rank == .fourth) &&
                  (validMovesD1[17].file == .E) && (validMovesD1[17].rank == .second) &&
                  (validMovesD1[18].file == .F) && (validMovesD1[18].rank == .third) &&
                  (validMovesD1[19].file == .G) && (validMovesD1[19].rank == .fourth) &&
                  (validMovesD1[20].file == .H) && (validMovesD1[20].rank == .fifth))
    }
    
    func testWhiteKingMovesStartingPosition() {
        // Given the user is on the board screen
        // And there is a king at the E1
        let piece = Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the king at E1
        let validMovesE1 = chessEngine.possibleMoves(piece: piece)
        // When they tap the king at E1
        // Then the E2, D1, F1, D2, F2 squares on the board will be highlighted
        XCTAssert(validMovesE1.count == 5)
        XCTAssert((validMovesE1[0].file == .E) && (validMovesE1[0].rank == .second) &&
                  (validMovesE1[1].file == .D) && (validMovesE1[1].rank == .first) &&
                  (validMovesE1[2].file == .F) && (validMovesE1[2].rank == .first) &&
                  (validMovesE1[3].file == .D) && (validMovesE1[3].rank == .second) &&
                  (validMovesE1[4].file == .F) && (validMovesE1[4].rank == .second))
    }
}
