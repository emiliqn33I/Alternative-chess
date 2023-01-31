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
        // And there is a rook at the H1
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
        
        // And there is a bishop at the C1
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
    
    func testWhiteBishopMovesStartingPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a bishop at the F1
        let bishopF1 = allpieces.first { $0.position.rank == .first && $0.position.file == .F }
        if bishopF1 == nil {
            XCTFail()
        }
        // And there is no piece on the way of the bishop at H1
        var positions = [Position]()
        var fileBishop = bishopF1!.position.file.rawValue
        var rankBishop = bishopF1!.position.rank.rawValue
        
        while(fileBishop > 0) {
            fileBishop -= 1
            rankBishop += 1
            let positon = Position(file: Position.File(rawValue: fileBishop)!, rank: Position.Rank(rawValue: rankBishop)!)
            positions.append(positon)
        }
        
        fileBishop = bishopF1!.position.file.rawValue
        rankBishop = bishopF1!.position.rank.rawValue

        while(fileBishop < 7) {
            fileBishop += 1
            rankBishop += 1
            let positon = Position(file: Position.File(rawValue: fileBishop)!, rank: Position.Rank(rawValue: rankBishop)!)
            positions.append(positon)
        }
        
        for position in positions {
            let piecesOnBishopWay = allpieces.filter { $0.position.file.rawValue == position.file.rawValue && $0.position.rank.rawValue > position.rank.rawValue }
            
            if piecesOnBishopWay.count != 0 {
                XCTFail()
            }
        }
        // When they tap the bishop F1
        // Then the E2, D3, C4, B5, A6, G2, H3  squares on the board will be highlighted
        let validMovesF1 = chessEngine.possibleMoves(piece: bishopF1!)
        XCTAssert(validMovesF1.count == 7)
        XCTAssert((validMovesF1[0].file == .E) && (validMovesF1[0].rank == .second) &&
                  (validMovesF1[1].file == .D) && (validMovesF1[1].rank == .third) &&
                  (validMovesF1[2].file == .C) && (validMovesF1[2].rank == .fourth) &&
                  (validMovesF1[3].file == .B) && (validMovesF1[3].rank == .fifth) &&
                  (validMovesF1[4].file == .A) && (validMovesF1[4].rank == .sixth) &&
                  (validMovesF1[5].file == .G) && (validMovesF1[5].rank == .second) &&
                  (validMovesF1[6].file == .H) && (validMovesF1[6].rank == .third))
    }
    
    func testWhiteBishopMovesRandomPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a bishop at the G3
        let bishopG3 = allpieces.first { $0.position.rank == .third && $0.position.file == .G }
        if bishopG3 == nil {
            XCTFail()
        }
        // And there is no piece on the way of the bishop at G3
        let validMovesG3 = chessEngine.possibleMoves(piece: bishopG3!)
        
        for moves in validMovesG3 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
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
    
    func testWhiteKnightMovesStartingPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a knight at the G1
        let knightG1 = allpieces.first { $0.position.rank == .first && $0.position.file == .G }
        if knightG1 == nil && knightG1?.type != .knight {
            XCTFail()
        }
        // And there is no piece on the way of the knight at G1
        let validMovesG1 = chessEngine.possibleMoves(piece: knightG1!)
        
        for moves in validMovesG1 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
        // When they tap the knight at G1
        // Then the F3, E2, H3 squares on the board will be highlighted
        XCTAssert(validMovesG1.count == 3)
        XCTAssert((validMovesG1[0].file == .F) && (validMovesG1[0].rank == .third) &&
                  (validMovesG1[1].file == .E) && (validMovesG1[1].rank == .second) &&
                  (validMovesG1[2].file == .H) && (validMovesG1[2].rank == .third))
    }
    
    func testWhiteKnightMovesRandomPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a knight at the B6
        let knightB6 = allpieces.first { $0.position.rank == .sixth && $0.position.file == .B }
        if knightB6 == nil && knightB6?.type != .knight {
            XCTFail()
        }
        // And there is no piece on the way of the knight at B6
        let validMovesB6 = chessEngine.possibleMoves(piece: knightB6!)
        
        for moves in validMovesB6 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
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
    
    func testWhiteQueenMovesStartingPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a queen at the D1
        let queenD1 = allpieces.first { $0.position.rank == .first && $0.position.file == .D }
        if queenD1 == nil || queenD1?.type != .queen {
            XCTFail()
        }
        // And there is no piece on the way of the queen at D1
        let validMovesD1 = chessEngine.possibleMoves(piece: queenD1!)
        
        for moves in validMovesD1 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
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
    
    func testWhiteQueenMovesRandomPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a queen at the E3
        let queenE3 = allpieces.first { $0.position.rank == .third && $0.position.file == .E }
        if queenE3 == nil || queenE3?.type != .queen {
            XCTFail()
        }
        // And there is no piece on the way of the queen at E3
        let validMovesE3 = chessEngine.possibleMoves(piece: queenE3!)
        
        for moves in validMovesE3 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
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
    
    func testWhiteKingMovesStartingPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a king at the E1
        let kingE1 = allpieces.first { $0.position.rank == .first && $0.position.file == .E }
        if kingE1 == nil || kingE1?.type != .king {
            XCTFail()
        }
        // And there is no piece on the way of the king at E1
        let validMovesE1 = chessEngine.possibleMoves(piece: kingE1!)
        
        for moves in validMovesE1 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
        // When they tap the king at E1
        // Then the E2, D1, F1, D2, F2 squares on the board will be highlighted
        XCTAssert(validMovesE1.count == 5)
        XCTAssert((validMovesE1[0].file == .E) && (validMovesE1[0].rank == .second) &&
                  (validMovesE1[1].file == .D) && (validMovesE1[1].rank == .first) &&
                  (validMovesE1[2].file == .F) && (validMovesE1[2].rank == .first) &&
                  (validMovesE1[3].file == .D) && (validMovesE1[3].rank == .second) &&
                  (validMovesE1[4].file == .F) && (validMovesE1[4].rank == .second))
    }
    
    func testWhiteKingMovesRandomPosition() {
        // Given the user is on the board screen
        let allpieces = chessEngine.pieces
        // And there is a king at the E6
        let kingE6 = allpieces.first { $0.position.rank == .sixth && $0.position.file == .E }
        if kingE6 == nil || kingE6?.type != .king {
            XCTFail()
        }
        // And there is no piece on the way of the king at E6
        let validMovesE6 = chessEngine.possibleMoves(piece: kingE6!)
        
        for moves in validMovesE6 {
            let pieces = allpieces.filter { ($0.position.rank.rawValue == moves.rank.rawValue) && ($0.position.file.rawValue == moves.file.rawValue) }
            if pieces.count != 0 {
                XCTFail()
            }
        }
        print(validMovesE6)
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
