//
//  BothColoursPossibleMovesPiecesStartingPosition.swift
//  AlternativeChessTests
//
//  Created by emo on 1.02.23.
//

import XCTest
@testable import AlternativeChess

final class BothColoursPossibleMovesPiecesStartingPosition: XCTestCase {

    func createSUT(piece: Piece) -> ChessEngine {
        return ChessEngine(pieces: [piece], turn: .white)
    }
    
    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces, turn: .white)
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
                      Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .A, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .B, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .C, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .D, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .E, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .F, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .G, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .H, rank: .seventh)),
                      Piece(type: .rook, colour: .black, position: Position(file: .A, rank: .eighth)),
                      Piece(type: .knight, colour: .black, position: Position(file: .B, rank: .eighth)),
                      Piece(type: .bishop, colour: .black, position: Position(file: .C, rank: .eighth)),
                      Piece(type: .queen, colour: .black, position: Position(file: .D, rank: .eighth)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth)),
                      Piece(type: .bishop, colour: .black, position: Position(file: .F, rank: .eighth)),
                      Piece(type: .knight, colour: .black, position: Position(file: .G, rank: .eighth)),
                      Piece(type: .rook, colour: .black, position: Position(file: .H, rank: .eighth))]
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
        
        let validMovesA7pawn = chessEngine.possibleMoves(piece: pieces[16])
        XCTAssertTrue(validMovesA7pawn.count == 2)
        XCTAssertTrue((validMovesA7pawn[0].file == .A) && (validMovesA7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesA7pawn[1].file == .A) && (validMovesA7pawn[1].rank == .fifth))
        
        let validMovesB7pawn = chessEngine.possibleMoves(piece: pieces[17])
        XCTAssertTrue(validMovesB7pawn.count == 2)
        XCTAssertTrue((validMovesB7pawn[0].file == .B) && (validMovesB7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesB7pawn[1].file == .B) && (validMovesB7pawn[1].rank == .fifth))
        
        let validMovesC7pawn = chessEngine.possibleMoves(piece: pieces[18])
        XCTAssertTrue(validMovesC7pawn.count == 2)
        XCTAssertTrue((validMovesC7pawn[0].file == .C) && (validMovesC7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesC7pawn[1].file == .C) && (validMovesC7pawn[1].rank == .fifth))
        
        let validMovesD7pawn = chessEngine.possibleMoves(piece: pieces[19])
        XCTAssertTrue(validMovesD7pawn.count == 2)
        XCTAssertTrue((validMovesD7pawn[0].file == .D) && (validMovesD7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesD7pawn[1].file == .D) && (validMovesD7pawn[1].rank == .fifth))
        
        let validMovesE7pawn = chessEngine.possibleMoves(piece: pieces[20])
        XCTAssertTrue(validMovesE7pawn.count == 2)
        XCTAssertTrue((validMovesE7pawn[0].file == .E) && (validMovesE7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesE7pawn[1].file == .E) && (validMovesE7pawn[1].rank == .fifth))
        
        let validMovesF7pawn = chessEngine.possibleMoves(piece: pieces[21])
        XCTAssertTrue(validMovesF7pawn.count == 2)
        XCTAssertTrue((validMovesF7pawn[0].file == .F) && (validMovesF7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesF7pawn[1].file == .F) && (validMovesF7pawn[1].rank == .fifth))
        
        let validMovesG7pawn = chessEngine.possibleMoves(piece: pieces[22])
        XCTAssertTrue(validMovesG7pawn.count == 2)
        XCTAssertTrue((validMovesG7pawn[0].file == .G) && (validMovesG7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesG7pawn[1].file == .G) && (validMovesG7pawn[1].rank == .fifth))
        
        let validMovesH7pawn = chessEngine.possibleMoves(piece: pieces[23])
        XCTAssertTrue(validMovesH7pawn.count == 2)
        XCTAssertTrue((validMovesH7pawn[0].file == .H) && (validMovesH7pawn[0].rank == .sixth))
        XCTAssertTrue((validMovesH7pawn[1].file == .H) && (validMovesH7pawn[1].rank == .fifth))
        
        let validMovesA8Rook = chessEngine.possibleMoves(piece: pieces[24])
        XCTAssertTrue(validMovesA8Rook.isEmpty)
        
        let validMovesB8Knight = chessEngine.possibleMoves(piece: pieces[25])
        XCTAssertTrue(validMovesB8Knight.count == 2)
        XCTAssertTrue((validMovesB8Knight[0].file == .C) && (validMovesB8Knight[0].rank == .sixth))
        XCTAssertTrue((validMovesB8Knight[1].file == .A) && (validMovesB8Knight[1].rank == .sixth))
        
        let validMovesC8Bishop = chessEngine.possibleMoves(piece: pieces[26])
        XCTAssertTrue(validMovesC8Bishop.isEmpty)
        
        let validMovesD8Queen = chessEngine.possibleMoves(piece: pieces[27])
        XCTAssertTrue(validMovesD8Queen.isEmpty)
        
        let validMovesE8King = chessEngine.possibleMoves(piece: pieces[28])
        XCTAssertTrue(validMovesE8King.isEmpty)
        
        let validMovesF8Bishop = chessEngine.possibleMoves(piece: pieces[29])
        XCTAssertTrue(validMovesF8Bishop.isEmpty)
        
        let validMovesG8Knight = chessEngine.possibleMoves(piece: pieces[30])
        XCTAssertTrue(validMovesG8Knight.count == 2)
        XCTAssertTrue((validMovesG8Knight[0].file == .H) && (validMovesG8Knight[0].rank == .sixth))
        XCTAssertTrue((validMovesG8Knight[1].file == .F) && (validMovesG8Knight[1].rank == .sixth))
        
        let validMovesH8Rook = chessEngine.possibleMoves(piece: pieces[31])
        XCTAssertTrue(validMovesH8Rook.isEmpty)
    }
}
