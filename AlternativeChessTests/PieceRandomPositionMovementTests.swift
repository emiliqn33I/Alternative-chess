//
//  PieceRandomPositionMovementTests.swift
//  AlternativeChessTests
//
//  Created by emo on 31.01.23.
//

import XCTest
@testable import AlternativeChess

final class PieceRandomPositionMovementTests: XCTestCase {
    func createSUT(piece: Piece) -> ChessEngine {
        return ChessEngine(pieces: [piece], turn: .white)
    }
    
    func testWhitePawnMovesRandomPosition() {
        // Given the user is on the board screen
        // And there is a pawn at the D5
        let piece = Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .fifth))
        let chessEngine = createSUT(piece: piece)
        // When they tap the pawn D5
        // Then the D6 square on the board will be highlighted
        let validMovesD6 = chessEngine.possibleMoves(piece: piece)
        XCTAssert(validMovesD6.count == 1)
        XCTAssert((validMovesD6[0].file == .D) && (validMovesD6[0].rank == .sixth))
    }
    
    func testWhiteRookMovesRandomPosition() {
        // Given the user is on the board screen
        // And there is a rook at the E4
        let piece = Piece(type: .rook, colour: .white, position: Position(file: .E, rank: .fourth))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the rook at E4
        let validMovesE4 = chessEngine.possibleMoves(piece: piece)
        // When they tap the rook E4
        // Then the E5, E6, E7, E8, E3, E2, E1, D4, C4, B4, A4, F4, G4, H4 squares on the board will be highlighted
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
    
    func testWhiteBishopMovesRandomPosition() {
        // Given the user is on the board screen
        // And there is a bishop at the G3
        let piece = Piece(type: .bishop, colour: .white, position: Position(file: .G, rank: .third))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the bishop at G3
        let validMovesG3 = chessEngine.possibleMoves(piece: piece)
        // When they tap the bishop G3
        // Then the F4, E5, D6, C7, B8, H4, H2, F2, E1 squares on the board will be highlighted
        XCTAssert(validMovesG3.count == 9)
        XCTAssert((validMovesG3[0].file == .F) && (validMovesG3[0].rank == .fourth) &&
                  (validMovesG3[1].file == .E) && (validMovesG3[1].rank == .fifth) &&
                  (validMovesG3[2].file == .D) && (validMovesG3[2].rank == .sixth) &&
                  (validMovesG3[3].file == .C) && (validMovesG3[3].rank == .seventh) &&
                  (validMovesG3[4].file == .B) && (validMovesG3[4].rank == .eighth) &&
                  (validMovesG3[5].file == .H) && (validMovesG3[5].rank == .fourth) &&
                  (validMovesG3[6].file == .H) && (validMovesG3[6].rank == .second) &&
                  (validMovesG3[7].file == .F) && (validMovesG3[7].rank == .second) &&
                  (validMovesG3[8].file == .E) && (validMovesG3[8].rank == .first))
    }
    
    func testWhiteKnightMovesRandomPosition() {
        // Given the user is on the board screen
        // And there is a knight at the B6
        let piece = Piece(type: .knight, colour: .white, position: Position(file: .B, rank: .sixth))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the knight at B6
        let validMovesB6 = chessEngine.possibleMoves(piece: piece)
        // When they tap the knight at B6
        // Then the A8, C8, D7, C4, D5, A4 squares on the board will be highlighted
        XCTAssert(validMovesB6.count == 6)
        XCTAssert((validMovesB6[0].file == .A) && (validMovesB6[0].rank == .eighth) &&
                  (validMovesB6[1].file == .C) && (validMovesB6[1].rank == .eighth) &&
                  (validMovesB6[2].file == .D) && (validMovesB6[2].rank == .seventh) &&
                  (validMovesB6[3].file == .C) && (validMovesB6[3].rank == .fourth) &&
                  (validMovesB6[4].file == .D) && (validMovesB6[4].rank == .fifth) &&
                  (validMovesB6[5].file == .A) && (validMovesB6[5].rank == .fourth))
    }
    
    func testWhiteQueenMovesRandomPosition() {
        // Given the user is on the board
        // And there is a queen at the E3
        let piece = Piece(type: .queen, colour: .white, position: Position(file: .E, rank: .third))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the queen at E3
        let validMovesE3 = chessEngine.possibleMoves(piece: piece)
        // When they tap the queen at E3
        // Then the E4, E5, E6, E7, E8, E2, E1, F3, G3, H3, D3, C3, B3, A3, F4, G5, H6, D4, C5, B6, A7, F2, G1, D2, C1 squares on the board will be highlighted
        XCTAssert(validMovesE3.count == 25)
        XCTAssert((validMovesE3[0].file == .E) && (validMovesE3[0].rank == .fourth) &&
                  (validMovesE3[1].file == .E) && (validMovesE3[1].rank == .fifth) &&
                  (validMovesE3[2].file == .E) && (validMovesE3[2].rank == .sixth) &&
                  (validMovesE3[3].file == .E) && (validMovesE3[3].rank == .seventh) &&
                  (validMovesE3[4].file == .E) && (validMovesE3[4].rank == .eighth) &&
                  (validMovesE3[5].file == .E) && (validMovesE3[5].rank == .second) &&
                  (validMovesE3[6].file == .E) && (validMovesE3[6].rank == .first) &&
                  (validMovesE3[7].file == .D) && (validMovesE3[7].rank == .third) &&
                  (validMovesE3[8].file == .C) && (validMovesE3[8].rank == .third) &&
                  (validMovesE3[9].file == .B) && (validMovesE3[9].rank == .third) &&
                  (validMovesE3[10].file == .A) && (validMovesE3[10].rank == .third) &&
                  (validMovesE3[11].file == .F) && (validMovesE3[11].rank == .third) &&
                  (validMovesE3[12].file == .G) && (validMovesE3[12].rank == .third) &&
                  (validMovesE3[13].file == .H) && (validMovesE3[13].rank == .third) &&
                  (validMovesE3[14].file == .D) && (validMovesE3[14].rank == .fourth) &&
                  (validMovesE3[15].file == .C) && (validMovesE3[15].rank == .fifth) &&
                  (validMovesE3[16].file == .B) && (validMovesE3[16].rank == .sixth) &&
                  (validMovesE3[17].file == .A) && (validMovesE3[17].rank == .seventh) &&
                  (validMovesE3[18].file == .F) && (validMovesE3[18].rank == .fourth) &&
                  (validMovesE3[19].file == .G) && (validMovesE3[19].rank == .fifth) &&
                  (validMovesE3[20].file == .H) && (validMovesE3[20].rank == .sixth) &&
                  (validMovesE3[21].file == .F) && (validMovesE3[21].rank == .second) &&
                  (validMovesE3[22].file == .G) && (validMovesE3[22].rank == .first) &&
                  (validMovesE3[23].file == .D) && (validMovesE3[23].rank == .second) &&
                  (validMovesE3[24].file == .C) && (validMovesE3[24].rank == .first))
    }
    
    func testWhiteKingMovesRandomPosition() {
        // Given the user is on the board screen
        // And there is a queen at the E6
        let piece = Piece(type: .king, colour: .white, position: Position(file: .E, rank: .sixth))
        let chessEngine = createSUT(piece: piece)
        // And there is no piece on the way of the king at E6
        let validMovesE6 = chessEngine.possibleMoves(piece: piece)
        // When they tap the king at E6
        // Then the E7, E5, D6, F6, D7, F7, F5, D5 squares on the board will be highlighted
        XCTAssert(validMovesE6.count == 8)
        XCTAssert((validMovesE6[0].file == .E) && (validMovesE6[0].rank == .seventh) &&
                  (validMovesE6[1].file == .E) && (validMovesE6[1].rank == .fifth) &&
                  (validMovesE6[2].file == .D) && (validMovesE6[2].rank == .sixth) &&
                  (validMovesE6[3].file == .F) && (validMovesE6[3].rank == .sixth) &&
                  (validMovesE6[4].file == .D) && (validMovesE6[4].rank == .seventh) &&
                  (validMovesE6[5].file == .D) && (validMovesE6[5].rank == .fifth) &&
                  (validMovesE6[6].file == .F) && (validMovesE6[6].rank == .fifth) &&
                  (validMovesE6[7].file == .F) && (validMovesE6[7].rank == .seventh) )
    }
}
