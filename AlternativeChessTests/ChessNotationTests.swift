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
    
    func testPawnTakesNotation() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .B, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .B, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "axb6")
    }
    
    func testPieceDifferentThanPawnTakesNotation() {
        let pieces = [Piece(.bishop, .white, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "Bxf6")
    }
    
    func testDisambiguatingRankNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .D, rank: .eighth)),
                      Piece(.rook, .white, Position(file: .H, rank: .eighth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "Rdf8")
    }
    
    func testDisambiguatingFileNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .fifth)),
                      Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .third)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .third))
        XCTAssertTrue(move.makeNotation() == "R5a3")
    }
    
    func testPromotionNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "a8Q")
    }
    
    func testCastleKingSideNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .H, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .G, rank: .first)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .G, rank: .first))
        print(move)
        XCTAssertTrue(move.makeNotation() == "O-O")
    }
    
    func testCastleQueenSideNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .first)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .first))
        XCTAssertTrue(move.makeNotation() == "O-O-O")
    }
    
    func testCheckTakeNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.rook, .black, Position(file: .A, rank: .eighth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "Rxa8+")
    }
    
    func testCheckMoveNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "Ra8+")
    }
    
    func testDoubleCheckMoveNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.bishop, .white, Position(file: .E, rank: .fourth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "Bc6++")
    }
    
    func testDoubleCheckTakeNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.bishop, .white, Position(file: .E, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .C, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "Bxc6++")
    }
    
    func testMateTakeNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .E, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .E, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(move.makeNotation() == "Qxe7#")
    }
    
    func testMateMoveNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(move.makeNotation() == "Qe7#")
    }
    
    func testNotationToMoveMovingAndMate() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let notation = "Qe7#"
        let madeMove = chessEngine.makeMove(from: notation)
        let aMove = Move(piece: Piece(.queen, .white, Position(file: .E, rank: .seventh)), from: Position(file: .H, rank: .seventh), type: .move, kingEffect: .mate(matedKing: pieces[3]), disambiguas: nil)
        XCTAssertTrue(madeMove == aMove)
        XCTAssertTrue(chessEngine.pieces[3].position == Position(file: .E, rank: .seventh))
    }
    
    func testNotationToMoveTakingAndMate() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.rook, .black, Position(file: .E, rank: .seventh)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth)),
                      Piece(.queen, .white, Position(file: .A, rank: .seventh))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let notation = "Qaxe7#"
        let madeMove = chessEngine.makeMove(from: notation)
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .E, rank: .seventh)))
        XCTAssertTrue(madeMove?.from == Position(file: .A, rank: .seventh))
        XCTAssertTrue(madeMove?.type == .take(taken: Piece(.rook, .black, Position(file: .E, rank: .seventh))))
        XCTAssertTrue(madeMove?.kingEffect == .mate(matedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMoveCheck() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth)),
                      Piece(.queen, .white, Position(file: .H, rank: .sixth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let notation = "Q6h8+"
        let madeMove = chessEngine.makeMove(from: notation)
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .H, rank: .eighth)))
        XCTAssertTrue(madeMove?.from == Position(file: .H, rank: .seventh))
        XCTAssertTrue(madeMove?.type == .move)
        XCTAssertTrue(madeMove?.kingEffect == .check(checkedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMovePromotionWithCheck() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let notation = "a8Q+"
        let madeMove = chessEngine.makeMove(from: notation)
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .A, rank: .eighth)))
        XCTAssertTrue(madeMove?.from == Position(file: .A, rank: .seventh))
        XCTAssertTrue(madeMove?.type == .promotion(promoted: Piece(.queen, .white, Position(file: .A, rank: .eighth))))
        XCTAssertTrue(madeMove?.kingEffect == .check(checkedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMoveCastleKingSide() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh)),
                      Piece(.rook, .white, Position(file: .H, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        XCTAssertTrue(validMoves.contains(Position(file: .G, rank: .first)))
        
        let notation = "O-O"
        let madeMove = chessEngine.makeMove(from: notation)
        XCTAssertTrue(madeMove?.piece == Piece(.king, .white, Position(file: .G, rank: .first)))
        XCTAssertTrue(madeMove?.from == Position(file: .E, rank: .first))
        XCTAssertTrue(madeMove?.type == .castle(rook: Piece(.rook, .white, Position(file: .F, rank: .first))))
        XCTAssertTrue(madeMove?.kingEffect == nil)
    }
    
    func testNotationToMoveCastleQueenSide() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh)),
                      Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .first)))
        
        let notation = "O-O-O"
        let madeMove = chessEngine.makeMove(from: notation)
        XCTAssertTrue(madeMove?.piece == Piece(.king, .white, Position(file: .C, rank: .first)))
        XCTAssertTrue(madeMove?.from == Position(file: .E, rank: .first))
        XCTAssertTrue(madeMove?.type == .castle(rook: Piece(.rook, .white, Position(file: .D, rank: .first))))
        XCTAssertTrue(madeMove?.kingEffect == nil)
    }
    
    func testNotationToMoveEnPassant() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .seventh)),
                      Piece(.bishop, .white, Position(file: .H, rank: .fifth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .black)
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .B, rank: .fifth))
        let notation = "axb6"
        let aMove = Move(piece: Piece(.pawn, .white, Position(file: .A, rank: .fifth)), from: Position(file: .A, rank: .fifth), type: .enPassant(takenPawn: pieces[1]), kingEffect: nil, disambiguas: nil)
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
    }
    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
