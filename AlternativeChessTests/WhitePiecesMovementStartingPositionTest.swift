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
        return ChessEngine(pieces: [piece], turn: .white)
    }
    
    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces, turn: .white)
    }
    
    func testWhitePiecesStartingPosition() {
        // Given the user is on the board screen
        // And there are every white piece
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .second)),
                      Piece(.pawn, .white, Position(file: .B, rank: .second)),
                      Piece(.pawn, .white, Position(file: .C, rank: .second)),
                      Piece(.pawn, .white, Position(file: .D, rank: .second)),
                      Piece(.pawn, .white, Position(file: .E, rank: .second)),
                      Piece(.pawn, .white, Position(file: .F, rank: .second)),
                      Piece(.pawn, .white, Position(file: .G, rank: .second)),
                      Piece(.pawn, .white, Position(file: .H, rank: .second)),
                      Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.knight, .white, Position(file: .B, rank: .first)),
                      Piece(.bishop, .white, Position(file: .C, rank: .first)),
                      Piece(.queen, .white, Position(file: .D, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.bishop, .white, Position(file: .F, rank: .first)),
                      Piece(.knight, .white, Position(file: .G, rank: .first)),
                      Piece(.rook, .white, Position(file: .H, rank: .first))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the a piece
        // Then the A4, A3, B4, B3, C3, C4, D3, D4, E3, E4, F3, F4, G3, G4, H3, H4(knight moves come along with A3, C3, F3, H3) square on the board will be highlighted
        let validMovesA2pawn = chessEngine.possibleMoves(piece: pieces[0])
        XCTAssertTrue(validMovesA2pawn.count == 2)
        XCTAssertTrue((validMovesA2pawn[0].file == .A) && (validMovesA2pawn[0].rank == .third))
        XCTAssertTrue((validMovesA2pawn[1].file == .A) && (validMovesA2pawn[1].rank == .fourth))
        
        let validMovesB2pawn = chessEngine.possibleMoves(piece: pieces[1])
        XCTAssertTrue(validMovesB2pawn.count == 2)
        XCTAssertTrue((validMovesB2pawn[0].file == .B) && (validMovesB2pawn[0].rank == .third))
        XCTAssertTrue((validMovesB2pawn[1].file == .B) && (validMovesB2pawn[1].rank == .fourth))
        
        let validMovesC2pawn = chessEngine.possibleMoves(piece: pieces[2])
        XCTAssertTrue(validMovesC2pawn.count == 2)
        XCTAssertTrue((validMovesC2pawn[0].file == .C) && (validMovesC2pawn[0].rank == .third))
        XCTAssertTrue((validMovesC2pawn[1].file == .C) && (validMovesC2pawn[1].rank == .fourth))
        
        let validMovesD2pawn = chessEngine.possibleMoves(piece: pieces[3])
        XCTAssertTrue(validMovesD2pawn.count == 2)
        XCTAssertTrue((validMovesD2pawn[0].file == .D) && (validMovesD2pawn[0].rank == .third))
        XCTAssertTrue((validMovesD2pawn[1].file == .D) && (validMovesD2pawn[1].rank == .fourth))
        
        let validMovesE2pawn = chessEngine.possibleMoves(piece: pieces[4])
        XCTAssertTrue(validMovesE2pawn.count == 2)
        XCTAssertTrue((validMovesE2pawn[0].file == .E) && (validMovesE2pawn[0].rank == .third))
        XCTAssertTrue((validMovesE2pawn[1].file == .E) && (validMovesE2pawn[1].rank == .fourth))
        
        let validMovesF2pawn = chessEngine.possibleMoves(piece: pieces[5])
        XCTAssertTrue(validMovesF2pawn.count == 2)
        XCTAssertTrue((validMovesF2pawn[0].file == .F) && (validMovesF2pawn[0].rank == .third))
        XCTAssertTrue((validMovesF2pawn[1].file == .F) && (validMovesF2pawn[1].rank == .fourth))
        
        let validMovesG2pawn = chessEngine.possibleMoves(piece: pieces[6])
        XCTAssertTrue(validMovesG2pawn.count == 2)
        XCTAssertTrue((validMovesG2pawn[0].file == .G) && (validMovesG2pawn[0].rank == .third))
        XCTAssertTrue((validMovesG2pawn[1].file == .G) && (validMovesG2pawn[1].rank == .fourth))
        
        let validMovesH2pawn = chessEngine.possibleMoves(piece: pieces[7])
        XCTAssertTrue(validMovesH2pawn.count == 2)
        XCTAssertTrue((validMovesH2pawn[0].file == .H) && (validMovesH2pawn[0].rank == .third))
        XCTAssertTrue((validMovesH2pawn[1].file == .H) && (validMovesH2pawn[1].rank == .fourth))
        
        let validMovesA1Rook = chessEngine.possibleMoves(piece: pieces[8])
        XCTAssertTrue(validMovesA1Rook.isEmpty)
        
        let validMovesB1Knight = chessEngine.possibleMoves(piece: pieces[9])
        XCTAssertTrue(validMovesB1Knight.count == 2)
        XCTAssertTrue((validMovesB1Knight[0].file == .A) && (validMovesB1Knight[0].rank == .third))
        XCTAssertTrue((validMovesB1Knight[1].file == .C) && (validMovesB1Knight[1].rank == .third))
        
        let validMovesC1Bishop = chessEngine.possibleMoves(piece: pieces[10])
        XCTAssertTrue(validMovesC1Bishop.isEmpty)
        
        let validMovesD1Queen = chessEngine.possibleMoves(piece: pieces[11])
        XCTAssertTrue(validMovesD1Queen.isEmpty)
        
        let validMovesE1King = chessEngine.possibleMoves(piece: pieces[12])
        XCTAssertTrue(validMovesE1King.isEmpty)
        
        let validMovesF1Bishop = chessEngine.possibleMoves(piece: pieces[13])
        XCTAssertTrue(validMovesF1Bishop.isEmpty)
        
        let validMovesG1Knight = chessEngine.possibleMoves(piece: pieces[14])
        XCTAssertTrue(validMovesG1Knight.count == 2)
        XCTAssertTrue((validMovesG1Knight[0].file == .F) && (validMovesG1Knight[0].rank == .third))
        XCTAssertTrue((validMovesG1Knight[1].file == .H) && (validMovesG1Knight[1].rank == .third))
        
        let validMovesH1Rook = chessEngine.possibleMoves(piece: pieces[15])
        XCTAssertTrue(validMovesH1Rook.isEmpty)
    }
}
