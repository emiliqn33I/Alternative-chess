//
//  PieceTakeTests.swift
//  AlternativeChessTests
//
//  Created by emo on 2.02.23.
//

import XCTest
@testable import AlternativeChess

final class PieceTakeTests: XCTestCase {

    func createSUT(pieces: [Piece]) -> ChessEngine {
        return ChessEngine(pieces: pieces, turn: .white)
    }
    
    func testPlacePiece() {
        // Given the user has obtained a certain set of VALID moves
        let pieces = [Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.pawn, .white, Position(file: .D, rank: .second)),
                      Piece(.queen, .white, Position(file: .B, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        let validMoves = chessEngine.validMoves(for: pieces[1])

        let move = validMoves.first!
    
//         When the user places the piece at any of the valid moves
        let _ = chessEngine.place(piece: pieces[1], at: move)
            
//         And the board will contain the piece at its new position
        let pieceAtNewPosition = chessEngine.piece(at: move)
        XCTAssertNotNil(pieceAtNewPosition)
        XCTAssertTrue(pieceAtNewPosition!.type == pieces[1].type)
        XCTAssertTrue(pieceAtNewPosition!.colour == pieces[1].colour)
    }

    func testWhitePawnTakes() {
        // Given the user is on the board screen
        // And there is white pawn at B2 and black pawns at B3 and A3
        let pieces = [Piece(.pawn, .black, Position(file: .C, rank: .third)),
                      Piece(.pawn, .white, Position(file: .B, rank: .second)),
                      Piece(.pawn, .black, Position(file: .A, rank: .third))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the B2 pawn
        // Then the C3 and A3 will be highlighted
        let validMovesB2pawn = chessEngine.possibleMoves(piece: pieces[1])
        XCTAssertTrue(validMovesB2pawn.count == 4)
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .C, rank: .third)))
        XCTAssertTrue(validMovesB2pawn.contains(Position(file: .A, rank: .third)))
    }
    
    func testWhiteRookTakes() {
        // Given the user is on the board screen
        // And there is white rook at D4 and black pawns at B4, D6, D2 and F4
        let pieces = [Piece(.pawn, .black, Position(file: .D, rank: .sixth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .fourth)),
                      Piece(.rook, .white, Position(file: .D, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .D, rank: .second)),
                      Piece(.pawn, .black, Position(file: .F, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the D4 rook
        // Then the B4, D6, D2 and F4 will be highlighted
        let validMovesD4Rook = chessEngine.possibleMoves(piece: pieces[2])
        XCTAssertTrue(validMovesD4Rook.count == 8)
        XCTAssertTrue(validMovesD4Rook.contains(Position(file: .D, rank: .sixth)))
        XCTAssertTrue(validMovesD4Rook.contains(Position(file: .B, rank: .fourth)))
        XCTAssertTrue(validMovesD4Rook.contains(Position(file: .D, rank: .second)))
        XCTAssertTrue(validMovesD4Rook.contains(Position(file: .F, rank: .fourth)))
    }
    
    func testWhiteBishopTakes() {
        // Given the user is on the board screen
        // And there is white rook at D4 and black pawns at B4, D6, D2 and F4
        let pieces = [Piece(.pawn, .black, Position(file: .B, rank: .sixth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .second)),
                      Piece(.bishop, .white, Position(file: .D, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .second)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the D4 bishop
        // Then the B4, D6, D2 and F4 will be highlighted
        let validMovesD4Bishop = chessEngine.possibleMoves(piece: pieces[2])
        XCTAssertTrue(validMovesD4Bishop.count == 8)
        XCTAssertTrue(validMovesD4Bishop.contains(Position(file: .B, rank: .sixth)))
        XCTAssertTrue(validMovesD4Bishop.contains(Position(file: .B, rank: .second)))
        XCTAssertTrue(validMovesD4Bishop.contains(Position(file: .F, rank: .second)))
        XCTAssertTrue(validMovesD4Bishop.contains(Position(file: .F, rank: .sixth)))
    }
    
    func testWhiteQueenTakes() {
        // Given the user is on the board screen
        // And there is white queen at D4 and black pawns at C5, C3, E3, E5, D2, D6, A4 and F6
        let pieces = [Piece(.pawn, .black, Position(file: .C, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .C, rank: .third)),
                      Piece(.pawn, .black, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .E, rank: .third)),
                      Piece(.queen, .white, Position(file: .D, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .D, rank: .second)),
                      Piece(.pawn, .black, Position(file: .D, rank: .sixth)),
                      Piece(.pawn, .black, Position(file: .A, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the D4 queen
        // Then the C5, C3, E3, E5, D2, D6, A4 and F6 will be highlighted
        let validMovesD4Queen = chessEngine.possibleMoves(piece: pieces[4])
        XCTAssertTrue(validMovesD4Queen.count == 13)
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .C, rank: .fifth)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .C, rank: .third)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .E, rank: .fifth)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .E, rank: .third)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .D, rank: .second)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .D, rank: .sixth)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .A, rank: .fourth)))
        XCTAssertTrue(validMovesD4Queen.contains(Position(file: .F, rank: .fourth)))
    }
    
    func testWhiteKingTakes() {
        // Given the user is on the board screen
        // And there is white king at D4 and black pawns at C5, D5, E5, C3, E3, D3
        let pieces = [Piece(.pawn, .black, Position(file: .C, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .D, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .C, rank: .third)),
                      Piece(.pawn, .black, Position(file: .D, rank: .third)),
                      Piece(.pawn, .black, Position(file: .E, rank: .third)),
                      Piece(.pawn, .black, Position(file: .D, rank: .third)),
                      Piece(.king, .white, Position(file: .D, rank: .fourth))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the D4 king
        // Then the C5, D5, E5, C3, E3, D3 will be highlighted
        let validMovesD4King = chessEngine.possibleMoves(piece: pieces[7])
        XCTAssertTrue(validMovesD4King.count == 8)
        XCTAssertTrue(validMovesD4King.contains(Position(file: .C, rank: .fifth)))
        XCTAssertTrue(validMovesD4King.contains(Position(file: .D, rank: .fifth)))
        XCTAssertTrue(validMovesD4King.contains(Position(file: .E, rank: .fifth)))
        XCTAssertTrue(validMovesD4King.contains(Position(file: .C, rank: .third)))
        XCTAssertTrue(validMovesD4King.contains(Position(file: .D, rank: .third)))
        XCTAssertTrue(validMovesD4King.contains(Position(file: .E, rank: .third)))
    }
    
    func testWhiteKnightTakes() {
        // Given the user is on the board screen
        // And there is white knight at D4 and black pawns at C6, C2, E2, E6, B3, B5, F3 and F5
        let pieces = [Piece(.pawn, .black, Position(file: .C, rank: .sixth)),
                      Piece(.pawn, .black, Position(file: .C, rank: .second)),
                      Piece(.pawn, .black, Position(file: .E, rank: .second)),
                      Piece(.pawn, .black, Position(file: .E, rank: .sixth)),
                      Piece(.knight, .white, Position(file: .D, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .third)),
                      Piece(.pawn, .black, Position(file: .B, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .third)),
                      Piece(.pawn, .black, Position(file: .F, rank: .fifth))]
        let chessEngine = createSUT(pieces: pieces)
        // When they tap the D4 queen
        // Then the C5, C3, E3, E5, D2, D6, A4 and F6 will be highlighted
        let validMovesD4Knight = chessEngine.possibleMoves(piece: pieces[4])
        XCTAssertTrue(validMovesD4Knight.count == 8)
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .C, rank: .sixth)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .C, rank: .second)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .E, rank: .second)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .E, rank: .sixth)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .B, rank: .third)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .B, rank: .fifth)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .F, rank: .third)))
        XCTAssertTrue(validMovesD4Knight.contains(Position(file: .F, rank: .fifth)))
    }
}
