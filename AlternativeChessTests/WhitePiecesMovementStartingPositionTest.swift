//
//  WhitePiecesMovementStartingPositionTest.swift
//  AlternativeChessTests
//
//  Created by emo on 31.01.23.
//

import XCTest
@testable import AlternativeChess

final class WhitePiecesMovementStartingPositionTest: XCTestCase {

    func createSUT(piece: Piece) -> ChessEngine {
        return ChessEngine(pieces: [piece])
    }
    
    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces)
    }
    
    func testWhitePiecesStartingPosition() {
        // Given the user is on the board screen
        // And there are every white piece
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .C, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .E, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .F, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .G, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .H, rank: .second)),
                      Piece(type: .rook, colour: .white, position: Position(file: .A, rank: .first)),
                      Piece(type: .knight, colour: .white, position: Position(file: .B, rank: .first)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .C, rank: .first)),
                      Piece(type: .queen, colour: .white, position: Position(file: .D, rank: .first)),
                      Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .F, rank: .first)),
                      Piece(type: .knight, colour: .white, position: Position(file: .G, rank: .first)),
                      Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the a piece
        // Then the A4, A3, B4, B3, C3, C4, D3, D4, E3, E4, F3, F4, G3, G4, H3, H4 square on the board will be highlighted
        var validMovesWhitePieces = [Position]()
        
        for piece in pieces {
            validMovesWhitePieces += chessEngine.possibleMoves(piece: piece)
        }

        XCTAssert(validMovesWhitePieces.count == 20)
        XCTAssert((validMovesWhitePieces[0].file == .A) && (validMovesWhitePieces[0].rank == .third))
        XCTAssert((validMovesWhitePieces[1].file == .A) && (validMovesWhitePieces[1].rank == .fourth))
        XCTAssert((validMovesWhitePieces[2].file == .B) && (validMovesWhitePieces[2].rank == .third))
        XCTAssert((validMovesWhitePieces[3].file == .B) && (validMovesWhitePieces[3].rank == .fourth))
        XCTAssert((validMovesWhitePieces[4].file == .C) && (validMovesWhitePieces[4].rank == .third))
        XCTAssert((validMovesWhitePieces[5].file == .C) && (validMovesWhitePieces[5].rank == .fourth))
        XCTAssert((validMovesWhitePieces[6].file == .D) && (validMovesWhitePieces[6].rank == .third))
        XCTAssert((validMovesWhitePieces[7].file == .D) && (validMovesWhitePieces[7].rank == .fourth))
        XCTAssert((validMovesWhitePieces[8].file == .E) && (validMovesWhitePieces[8].rank == .third))
        XCTAssert((validMovesWhitePieces[9].file == .E) && (validMovesWhitePieces[9].rank == .fourth))
        XCTAssert((validMovesWhitePieces[10].file == .F) && (validMovesWhitePieces[10].rank == .third))
        XCTAssert((validMovesWhitePieces[11].file == .F) && (validMovesWhitePieces[11].rank == .fourth))
        XCTAssert((validMovesWhitePieces[12].file == .G) && (validMovesWhitePieces[12].rank == .third))
        XCTAssert((validMovesWhitePieces[13].file == .G) && (validMovesWhitePieces[13].rank == .fourth))
        XCTAssert((validMovesWhitePieces[14].file == .H) && (validMovesWhitePieces[14].rank == .third))
        XCTAssert((validMovesWhitePieces[15].file == .H) && (validMovesWhitePieces[15].rank == .fourth))
        XCTAssert((validMovesWhitePieces[16].file == .A) && (validMovesWhitePieces[16].rank == .third))
        XCTAssert((validMovesWhitePieces[17].file == .C) && (validMovesWhitePieces[17].rank == .third))
        XCTAssert((validMovesWhitePieces[18].file == .F) && (validMovesWhitePieces[18].rank == .third))
        XCTAssert((validMovesWhitePieces[19].file == .H) && (validMovesWhitePieces[19].rank == .third))
    }
}
