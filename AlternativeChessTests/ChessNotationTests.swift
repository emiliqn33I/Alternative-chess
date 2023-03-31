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
        let pieces = [Piece(.pawn, .white, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        XCTAssertTrue(move.notationOfMove == "exf6")
    }
    
    func testPieceDifferentThanPawnTakesNotation() {
        // Given the user has a white pawn at E5 and black pawn at F5, and king at E1 for validating moves
        let pieces = [Piece(.bishop, .white, Position(file: .E, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .F, rank: .sixth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        // Then the user will be able to take the pawn at F5 while moveing to F6 with the white pawn, and the pawn at F5 will be removed
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .sixth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .sixth))
        XCTAssertTrue(move.notationOfMove == "Bxf6")
    }
    
    func testDisambiguatingRankNotation() {
        let pieces = [Piece(.rook, .white, Position(file: .D, rank: .eighth)),
                      Piece(.rook, .white, Position(file: .H, rank: .eighth)),
                      Piece(.king, .white, Position(file: .E, rank: .first))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[0])
        XCTAssertTrue(validMoves.contains(Position(file: .F, rank: .eighth)))
        
        let move = chessEngine.place(piece: pieces[0], at: Position(file: .F, rank: .eighth))
        XCTAssertTrue(move.notationOfMove == "Rdf8")
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
        XCTAssertTrue(move.notationOfMove == "R5a3")
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
        XCTAssertTrue(move.notationOfMove == "a8Q")
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
        XCTAssertTrue(move.notationOfMove == "O-O")
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
        XCTAssertTrue(move.notationOfMove == "O-O-O")
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
        XCTAssertTrue(move.notationOfMove == "Rxa8+")
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
        XCTAssertTrue(move.notationOfMove == "Ra8+")
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
        XCTAssertTrue(move.notationOfMove == "Bc6++")
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
        XCTAssertTrue(move.notationOfMove == "Bxc6++")
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
        XCTAssertTrue(move.notationOfMove == "Qxe7#")
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "1-0")
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
        XCTAssertTrue(move.notationOfMove == "Qe7#")
        XCTAssertTrue(chessEngine.history.last?.notationOfMove == "1-0")
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
        let aMove = Move(piece: Piece(.queen, .white, Position(file: .H, rank: .seventh)), from: Position(file: .H, rank: .seventh), to: Position(file: .E, rank: .seventh), type: .move, kingEffect: .mate(matedKing: pieces[3]), notationOfMove: "Qe7#")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
    }
    
    func testNotationToMoveTakingAndMate() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.rook, .black, Position(file: .E, rank: .seventh)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[2])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))

        let notation = "Qxe7#"
        let aMove = Move(piece: Piece(.queen, .white, Position(file: .H, rank: .seventh)), from: Position(file: .H, rank: .seventh), to: Position(file: .E, rank: .seventh), type: .take(taken: pieces[1]), kingEffect: .mate(matedKing: pieces[4]), notationOfMove: "Qxe7#")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
    }
    
    func testNotationToMoveCheck() {
        let pieces = [Piece(.rook, .white, Position(file: .E, rank: .second)),
                      Piece(.queen, .white, Position(file: .H, rank: .seventh)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let validMoves = chessEngine.validMoves(for: pieces[1])
        XCTAssertTrue(validMoves.contains(Position(file: .E, rank: .seventh)))

        let notation = "Qh8+"
        let aMove = Move(piece: Piece(.queen, .white, Position(file: .H, rank: .seventh)), from: Position(file: .H, rank: .seventh), to: Position(file: .H, rank: .eighth), type: .move, kingEffect: .check(checkedKing: pieces[3]), notationOfMove: "Qh8+")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
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
        let aMove = Move(piece: Piece(.pawn, .white, Position(file: .A, rank: .seventh)), from: Position(file: .A, rank: .seventh), to: Position(file: .A, rank: .eighth), type: .promotion(promoted: pieces[0]), kingEffect: .check(checkedKing: pieces[3]), notationOfMove: "a8Q+")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
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
        let aMove = Move(piece: Piece(.king, .white, Position(file: .E, rank: .first)), from: Position(file: .E, rank: .first), to: Position(file: .G, rank: .first), type: .castle(rook: pieces[1]), kingEffect: nil, notationOfMove: "O-O")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
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
        let aMove = Move(piece: Piece(.king, .white, Position(file: .E, rank: .first)), from: Position(file: .E, rank: .first), to: Position(file: .C, rank: .first), type: .castle(rook: pieces[1]), kingEffect: nil, notationOfMove: "O-O-O")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
    }
    
    func testNotationToMoveEnPassant() {
        let pieces = [Piece(.pawn, .white, Position(file: .A, rank: .fifth)),
                      Piece(.pawn, .black, Position(file: .B, rank: .seventh)),
                      Piece(.bishop, .white, Position(file: .H, rank: .fifth)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth))]
        let chessEngine = createSUT(pieces: pieces, turn: .white)
        let _ = chessEngine.place(piece: pieces[1], at: Position(file: .B, rank: .fifth))

        let notation = "axb6"
        let aMove = Move(piece: Piece(.pawn, .white, Position(file: .A, rank: .fifth)), from: Position(file: .A, rank: .fifth), to: Position(file: .B, rank: .sixth), type: .enPassant(takenPawn: pieces[1]), kingEffect: nil, notationOfMove: "axb6")
        XCTAssertTrue(chessEngine.makeMove(from: notation) == aMove)
    }

    
    private func createSUT(pieces: [Piece], turn: Piece.Color) -> ChessEngine {
        ChessEngine(pieces: pieces, turn: turn)
    }
}
