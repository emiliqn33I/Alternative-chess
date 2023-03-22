//
//  ChessNotationTests.swift
//  AlternativeChessTests
//
//  Created by emo on 10.03.23.
//

import XCTest
@testable import AlternativeChess

final class ChessNotationTests: XCTestCase {

    func testChessNotation() {
        let pieces = [Piece(.pawn, .white, Position(file: .G, rank: .seventh)),
                      Piece(.king, .white, Position(file: .F, rank: .first)),
                      Piece(.rook, .white, Position(file: .E, rank: .seventh)),
                      Piece(.knight, .white, Position(file: .D, rank: .first)),
                      Piece(.bishop, .white, Position(file: .C, rank: .seventh)),
                      Piece(.queen, .white, Position(file: .A, rank: .first)),
                      Piece(.duck, .yellow, Position(file: .B, rank: .seventh)) ]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        
        let notationOfPawn = chessEngine.pieces[0].notation
        XCTAssertTrue(notationOfPawn == "g7")
        
        let notationOfKing = chessEngine.pieces[1].notation
        XCTAssertTrue(notationOfKing == "Kf1")
        
        let notationOfRook = chessEngine.pieces[2].notation
        XCTAssertTrue(notationOfRook == "Re7")
        
        let notationOfKnight = chessEngine.pieces[3].notation
        XCTAssertTrue(notationOfKnight == "Nd1")
        
        let notationOfBishop = chessEngine.pieces[4].notation
        XCTAssertTrue(notationOfBishop == "Bc7")
        
        let notationOfQueen = chessEngine.pieces[5].notation
        XCTAssertTrue(notationOfQueen == "Qa1")
        
        let notationOfDuck = chessEngine.pieces[6].notation
        XCTAssertTrue(notationOfDuck == "Db7")
    }
    
    func testNotPawnTakesNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.pawn, .white, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "exf6")
    }
    
    func testPawnTakesNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.bishop, .white, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "Bxf6")
    }
    
    func testDisambiguatingRankNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .D, rank: .eighth)),
                      Piece(.rook, .white, Position(file: .H, rank: .eighth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .eighth)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .eighth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "Rdf8")
    }
    
    func testDisambiguatingFileNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .A, rank: .fifth)),
                      Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .third)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .third))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "R5a3")
    }
    
    func testPromotionNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "a8Q")
    }
    
    func testCastleKingSideNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .H, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .G, rank: .first)))
        
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .G, rank: .first))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "O-O")
    }
    
    func testCastleQueenSideNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .first)))
        
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .first))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "O-O-O")
    }
    
    func testCheckTakeNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.rook, .black, Position(file: .A, rank: .eighth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "Rxa8+")
    }
    
    func testCheckMoveNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "Ra8+")
    }
    
    func testDoubleCheckMoveNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.bishop, .white, Position(file: .E, rank: .fourth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .sixth)))
        
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "Bc6++")
    }

    func testDoubleCheckTakeNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.bishop, .white, Position(file: .E, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .C, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .sixth)))
        
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .sixth))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "Bxc6++")
    }
    
    func testMateTakeNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .E, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .E, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history[0].notationOfMove == "Qxe7#")
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "1-0")
    }
    
    func testMateMoveNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        var pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        pieces = chessEngine.pieces
        XCTAssertTrue(chessEngine.history[0].notationOfMove == "Qe7#")
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "1-0")
    }
    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
