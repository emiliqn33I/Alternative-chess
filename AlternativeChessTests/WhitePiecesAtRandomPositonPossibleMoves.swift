//
//  WhitePiecesAtRandomPositonPossibleMoves.swift
//  AlternativeChessTests
//
//  Created by emo on 1.02.23.
//

import XCTest
@testable import AlternativeChess

final class WhitePiecesAtRandomPositonPossibleMoves: XCTestCase {

    func createSUT(piece: Piece) -> ChessEngine {
        return ChessEngine(pieces: [piece], turn: true)
    }
    
    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces, turn: true)
    }
    
    func testWhitePiecesRandomPosition() {
        // Given the user is on the board screen
        // And there are every white piece
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .C, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .seventh)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .E, rank: .fourth)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .F, rank: .third)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .G, rank: .third)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .H, rank: .second)),
                      Piece(type: .rook, colour: .white, position: Position(file: .D, rank: .fifth)),
                      Piece(type: .knight, colour: .white, position: Position(file: .C, rank: .third)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .E, rank: .third)),
                      Piece(type: .queen, colour: .white, position: Position(file: .B, rank: .fourth)),
                      Piece(type: .king, colour: .white, position: Position(file: .F, rank: .second)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .H, rank: .third)),
                      Piece(type: .knight, colour: .white, position: Position(file: .E, rank: .second)),
                      Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the a piece
        // Then the the piece squares will be shown on the board
        let validMovesA2pawn = chessEngine.possibleMoves(piece: pieces[0])
        XCTAssertTrue(validMovesA2pawn.count == 2)
        XCTAssertTrue(validMovesA2pawn[0].file == .A && validMovesA2pawn[0].rank == .third)
        XCTAssertTrue(validMovesA2pawn[1].file == .A && validMovesA2pawn[1].rank == .fourth)
        
        let validMovesB2pawn = chessEngine.possibleMoves(piece: pieces[1])
        XCTAssertTrue(validMovesB2pawn.count == 1)
        XCTAssertTrue(validMovesB2pawn[0].file == .B && validMovesB2pawn[0].rank == .third)
        
        let validMovesC2pawn = chessEngine.possibleMoves(piece: pieces[2])
        XCTAssertTrue(validMovesC2pawn.isEmpty)
        
        
        let validMovesD7pawn = chessEngine.possibleMoves(piece: pieces[3])
        XCTAssertTrue(validMovesD7pawn.count == 1)
        XCTAssertTrue(validMovesD7pawn[0].file == .D && validMovesD7pawn[0].rank == .eighth)
        
        let validMovesE4pawn = chessEngine.possibleMoves(piece: pieces[4])
        XCTAssertTrue(validMovesE4pawn.count == 1)
        XCTAssertTrue((validMovesE4pawn[0].file == .E) && (validMovesE4pawn[0].rank == .fifth))
        
        let validMovesF3pawn = chessEngine.possibleMoves(piece: pieces[5])
        XCTAssertTrue(validMovesF3pawn.count == 1)
        XCTAssertTrue((validMovesF3pawn[0].file == .F) && (validMovesF3pawn[0].rank == .fourth))
        
        let validMovesG3pawn = chessEngine.possibleMoves(piece: pieces[6])
        XCTAssertTrue(validMovesG3pawn.count == 1)
        XCTAssertTrue((validMovesG3pawn[0].file == .G) && (validMovesG3pawn[0].rank == .fourth))
        
        let validMovesH2pawn = chessEngine.possibleMoves(piece: pieces[7])
        XCTAssertTrue(validMovesH2pawn.isEmpty)
        
        let validMovesD5Rook = chessEngine.possibleMoves(piece: pieces[8])
        XCTAssertTrue(validMovesD5Rook.count == 12)
        XCTAssertTrue(validMovesD5Rook[0].file == .D && validMovesD5Rook[0].rank == .sixth)
        XCTAssertTrue(validMovesD5Rook[1].file == .D && validMovesD5Rook[1].rank == .fourth)
        XCTAssertTrue(validMovesD5Rook[2].file == .D && validMovesD5Rook[2].rank == .third)
        XCTAssertTrue(validMovesD5Rook[3].file == .D && validMovesD5Rook[3].rank == .second)
        XCTAssertTrue(validMovesD5Rook[4].file == .D && validMovesD5Rook[4].rank == .first)
        XCTAssertTrue(validMovesD5Rook[5].file == .C && validMovesD5Rook[5].rank == .fifth)
        XCTAssertTrue(validMovesD5Rook[6].file == .B && validMovesD5Rook[6].rank == .fifth)
        XCTAssertTrue(validMovesD5Rook[7].file == .A && validMovesD5Rook[7].rank == .fifth)
        XCTAssertTrue(validMovesD5Rook[8].file == .E && validMovesD5Rook[8].rank == .fifth)
        XCTAssertTrue(validMovesD5Rook[9].file == .F && validMovesD5Rook[9].rank == .fifth)
        XCTAssertTrue(validMovesD5Rook[10].file == .G && validMovesD5Rook[10].rank == .fifth)
        XCTAssertTrue(validMovesD5Rook[11].file == .H && validMovesD5Rook[11].rank == .fifth)
        
        let validMovesC3Knight = chessEngine.possibleMoves(piece: pieces[9])
        XCTAssertTrue(validMovesC3Knight.count == 4)
        XCTAssertTrue(validMovesC3Knight[0].file == .B && validMovesC3Knight[0].rank == .fifth)
        XCTAssertTrue(validMovesC3Knight[1].file == .A && validMovesC3Knight[1].rank == .fourth)
        XCTAssertTrue(validMovesC3Knight[2].file == .D && validMovesC3Knight[2].rank == .first)
        XCTAssertTrue(validMovesC3Knight[3].file == .B && validMovesC3Knight[3].rank == .first)
        
        let validMovesE3Bishop = chessEngine.possibleMoves(piece: pieces[10])
        XCTAssertTrue(validMovesE3Bishop.count == 9)
        XCTAssertTrue(validMovesE3Bishop[0].file == .D && validMovesE3Bishop[0].rank == .fourth)
        XCTAssertTrue(validMovesE3Bishop[1].file == .C && validMovesE3Bishop[1].rank == .fifth)
        XCTAssertTrue(validMovesE3Bishop[2].file == .B && validMovesE3Bishop[2].rank == .sixth)
        XCTAssertTrue(validMovesE3Bishop[3].file == .A && validMovesE3Bishop[3].rank == .seventh)
        XCTAssertTrue(validMovesE3Bishop[4].file == .F && validMovesE3Bishop[4].rank == .fourth)
        XCTAssertTrue(validMovesE3Bishop[5].file == .G && validMovesE3Bishop[5].rank == .fifth)
        XCTAssertTrue(validMovesE3Bishop[6].file == .H && validMovesE3Bishop[6].rank == .sixth)
        XCTAssertTrue(validMovesE3Bishop[7].file == .D && validMovesE3Bishop[7].rank == .second)
        XCTAssertTrue(validMovesE3Bishop[8].file == .C && validMovesE3Bishop[8].rank == .first)
        
        let validMovesD1Queen = chessEngine.possibleMoves(piece: pieces[11])
        XCTAssertTrue(validMovesD1Queen.count == 14)
        XCTAssertTrue(validMovesD1Queen[0].file == .B && validMovesD1Queen[0].rank == .fifth)
        XCTAssertTrue(validMovesD1Queen[1].file == .B && validMovesD1Queen[1].rank == .sixth)
        XCTAssertTrue(validMovesD1Queen[2].file == .B && validMovesD1Queen[2].rank == .seventh)
        XCTAssertTrue(validMovesD1Queen[3].file == .B && validMovesD1Queen[3].rank == .eighth)
        XCTAssertTrue(validMovesD1Queen[4].file == .B && validMovesD1Queen[4].rank == .third)
        XCTAssertTrue(validMovesD1Queen[5].file == .A && validMovesD1Queen[5].rank == .fourth)
        XCTAssertTrue(validMovesD1Queen[6].file == .C && validMovesD1Queen[6].rank == .fourth)
        XCTAssertTrue(validMovesD1Queen[7].file == .D && validMovesD1Queen[7].rank == .fourth)
        XCTAssertTrue(validMovesD1Queen[8].file == .A && validMovesD1Queen[8].rank == .fifth)
        XCTAssertTrue(validMovesD1Queen[9].file == .C && validMovesD1Queen[9].rank == .fifth)
        XCTAssertTrue(validMovesD1Queen[10].file == .D && validMovesD1Queen[10].rank == .sixth)
        XCTAssertTrue(validMovesD1Queen[11].file == .E && validMovesD1Queen[11].rank == .seventh)
        XCTAssertTrue(validMovesD1Queen[12].file == .F && validMovesD1Queen[12].rank == .eighth)
        XCTAssertTrue(validMovesD1Queen[13].file == .A && validMovesD1Queen[13].rank == .third)
        
        let validMovesE1King = chessEngine.possibleMoves(piece: pieces[12])
        XCTAssertTrue(validMovesE1King.count == 4)
        XCTAssertTrue(validMovesE1King[0].file == .F && validMovesE1King[0].rank == .first)
        XCTAssertTrue(validMovesE1King[1].file == .G && validMovesE1King[1].rank == .second)
        XCTAssertTrue(validMovesE1King[2].file == .E && validMovesE1King[2].rank == .first)
        XCTAssertTrue(validMovesE1King[3].file == .G && validMovesE1King[3].rank == .first)
        
        let validMovesF1Bishop = chessEngine.possibleMoves(piece: pieces[13])
        XCTAssertTrue(validMovesF1Bishop.count == 5)
        XCTAssertTrue(validMovesF1Bishop[0].file == .G && validMovesF1Bishop[0].rank == .fourth)
        XCTAssertTrue(validMovesF1Bishop[1].file == .F && validMovesF1Bishop[1].rank == .fifth)
        XCTAssertTrue(validMovesF1Bishop[2].file == .E && validMovesF1Bishop[2].rank == .sixth)
        XCTAssertTrue(validMovesF1Bishop[3].file == .G && validMovesF1Bishop[3].rank == .second)
        XCTAssertTrue(validMovesF1Bishop[4].file == .F && validMovesF1Bishop[4].rank == .first)
        
        let validMovesG1Knight = chessEngine.possibleMoves(piece: pieces[14])
        XCTAssertTrue(validMovesG1Knight.count == 4)
        XCTAssertTrue(validMovesG1Knight[0].file == .D && validMovesG1Knight[0].rank == .fourth)
        XCTAssertTrue(validMovesG1Knight[1].file == .F && validMovesG1Knight[1].rank == .fourth)
        XCTAssertTrue(validMovesG1Knight[2].file == .G && validMovesG1Knight[2].rank == .first)
        XCTAssertTrue(validMovesG1Knight[3].file == .C && validMovesG1Knight[3].rank == .first)
        
        let validMovesH1Rook = chessEngine.possibleMoves(piece: pieces[15])
        XCTAssertTrue(validMovesH1Rook.count == 7)
        XCTAssertTrue(validMovesH1Rook[0].file == .G && validMovesH1Rook[0].rank == .first)
        XCTAssertTrue(validMovesH1Rook[1].file == .F && validMovesH1Rook[1].rank == .first)
        XCTAssertTrue(validMovesH1Rook[2].file == .E && validMovesH1Rook[2].rank == .first)
        XCTAssertTrue(validMovesH1Rook[3].file == .D && validMovesH1Rook[3].rank == .first)
        XCTAssertTrue(validMovesH1Rook[4].file == .C && validMovesH1Rook[4].rank == .first)
        XCTAssertTrue(validMovesH1Rook[5].file == .B && validMovesH1Rook[5].rank == .first)
        XCTAssertTrue(validMovesH1Rook[6].file == .A && validMovesH1Rook[6].rank == .first)
    }
}
