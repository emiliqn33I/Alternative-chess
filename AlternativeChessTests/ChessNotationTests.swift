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
                      Piece(.pawn, .black, Position(file: .B, rank: .sixth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .B, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .B, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "axb6")
    }
    
    func testPieceDifferentThanPawnTakesNotation() {
        let pieces = [Piece(.bishop, .white, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "Bxf6")
    }
    
    func testDisambiguatingRankNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .D, rank: .eighth)),
                      Piece(.rook, .white, Position(file: .H, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "Rdf8")
    }
    
    func testDisambiguatingFileNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .fifth)),
                      Piece(.rook, .white, Position(file: .A, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .third)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .third))
        XCTAssertTrue(move.makeNotation() == "R5a3")
    }
    
    func testPromotionNotation() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "a8Q")
    }
    
    func testCastleKingSideNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .H, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .G, rank: .first)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .G, rank: .first))
        print(move)
        XCTAssertTrue(move.makeNotation() == "O-O")
    }
    
    func testCastleQueenSideNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .first)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .first))
        XCTAssertTrue(move.makeNotation() == "O-O-O")
    }
    
    func testCheckTakeNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.rook, .black, Position(file: .A, rank: .eighth)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "Rxa8+")
    }
    
    func testCheckMoveNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(move.makeNotation() == "Ra8+")
    }
    
    func testDoubleCheckMoveNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.bishop, .white, Position(file: .E, rank: .fourth)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "Bc6++")
    }
    
    func testDoubleCheckTakeNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.bishop, .white, Position(file: .E, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .C, rank: .sixth)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .sixth))
        XCTAssertTrue(move.makeNotation() == "Bxc6++")
    }
    
    func testMateTakeNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .E, rank: .fourth)),
                      Piece(.pawn, .black, Position(file: .E, rank: .seventh)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(move.makeNotation() == "Qxe7#")
    }
    
    func testMateMoveNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let move = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(move.makeNotation() == "Qe7#")
    }
    
    func testDuckNotation() {
        let pieces = [Piece(.duck, .yellow, Position(file: .E, rank: .second)),
                      Piece(.pawn, .white, Position(file: .E, rank: .third))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(move.makeNotation() == "De7")
    }
    
    func testNotationToMoveMovingAndMate() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let notation = "Qe7#"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .E, rank: .seventh)))
        XCTAssertTrue(madeMove?.from == Position(file: .H, rank: .seventh))
        XCTAssertTrue(madeMove?.type == .move)
        XCTAssertTrue(madeMove?.kingEffect == .mate(matedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMoveTakingAndMate() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.rook, .black, Position(file: .E, rank: .seventh)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth)),
                      Piece(.queen, .white, Position(file: .A, rank: .seventh))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[4])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))
        
        let notation = "Qaxe7#"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[4], at: Position(file: .E, rank: .seventh))
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .E, rank: .seventh)))
        XCTAssertTrue(madeMove?.from == Position(file: .A, rank: .seventh))
        XCTAssertTrue(madeMove?.type == .take(taken: Piece(.rook, .black, Position(file: .E, rank: .seventh))))
        XCTAssertTrue(madeMove?.kingEffect == .mate(matedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMoveCheck() {
        let pieces = [Piece(.queen, .white, Position(file: .H, rank: .second)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth)),
                      Piece(.queen, .white, Position(file: .H, rank: .sixth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        XCTAssertTrue(validMoves.contains(Position(file: .H, rank: .fifth)))
        
        let notation = "Q6h5+"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[2], at: Position(file: .H, rank: .fifth))
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .H, rank: .fifth)))
        XCTAssertTrue(madeMove?.from == Position(file: .H, rank: .sixth))
        XCTAssertTrue(madeMove?.type == .move)
        XCTAssertTrue(madeMove?.kingEffect == .check(checkedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMovePromotionWithCheck() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .seventh)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .A, rank: .eighth)))
        
        let notation = "a8Q+"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .A, rank: .eighth))
        XCTAssertTrue(madeMove?.piece == Piece(.queen, .white, Position(file: .A, rank: .eighth)))
        XCTAssertTrue(madeMove?.from == Position(file: .A, rank: .seventh))
        XCTAssertTrue(madeMove?.type == .promotion(promoted: Piece(.queen, .white, Position(file: .A, rank: .eighth))))
        XCTAssertTrue(madeMove?.kingEffect == .check(checkedKing: Piece(.king, .black, Position(file: .E, rank: .eighth))))
    }
    
    func testNotationToMoveCastleKingSide() {
        let pieces = [Piece(.rook, .white, Position(file: .H, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .G, rank: .first)))
        
        let notation = "O-O"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .G, rank: .first))
        XCTAssertTrue(madeMove?.piece == Piece(.king, .white, Position(file: .G, rank: .first)))
        XCTAssertTrue(madeMove?.from == Position(file: .E, rank: .first))
        XCTAssertTrue(madeMove?.type == .castle(rook: Piece(.rook, .white, Position(file: .F, rank: .first))))
        XCTAssertTrue(madeMove?.kingEffect == nil)
    }
    
    func testNotationToMoveCastleQueenSide() {
        let pieces = [Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .first)))
        
        let notation = "O-O-O"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .C, rank: .first))
        XCTAssertTrue(madeMove?.piece == Piece(.king, .white, Position(file: .C, rank: .first)))
        XCTAssertTrue(madeMove?.from == Position(file: .E, rank: .first))
        XCTAssertTrue(madeMove?.type == .castle(rook: Piece(.rook, .white, Position(file: .D, rank: .first))))
        XCTAssertTrue(madeMove?.kingEffect == nil)
    }
    
    func testNotationToMoveEnPassant() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .seventh))]
        let chessEngine = createSUT(pieces: pieces, turn: .black)
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .B, rank: .fifth))
        let notation = "axb6"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .B, rank: .sixth))
        XCTAssertTrue(madeMove?.piece == Piece(.pawn, .white, Position(file: .B, rank: .sixth)))
        XCTAssertTrue(madeMove?.from == Position(file: .A, rank: .fifth))
        XCTAssertTrue(madeMove?.type == .enPassant(takenPawn: Piece(.pawn, .black, Position(file: .B, rank: .fifth))))
    }
    
    func testNotationToMoveDuckMove() {
        let pieces = [Piece(.duck, .yellow, Position(file: .A, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .C, rank: .first)))
        
        let notation = "Dc1"
        let madeMove = chessEngine.makeMove(from: notation)
        let _ = chessEngine.place(piece: pieces[0], at: Position(file: .C, rank: .first))
        XCTAssertTrue(madeMove?.piece == Piece(.duck, .yellow, Position(file: .C, rank: .first)))
        XCTAssertTrue(madeMove?.from == Position(file: .A, rank: .first))
        XCTAssertTrue(madeMove?.type == .move)
        XCTAssertTrue(madeMove?.kingEffect == nil)
    }
    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
