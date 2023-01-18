//
//  AlternativeChessTests.swift
//  AlternativeChessTests
//
//  Created by Petar Bel on 15.12.22.
//

import XCTest
@testable import AlternativeChess

final class AlternativeChessTests: XCTestCase {
    func test_ChessBoardViewControllerContainsChessView() {
        // Given the app is launched
        // When the user navigates to the chess board view
        let chessBoardViewController = ChessBoardViewController()
        chessBoardViewController.loadViewIfNeeded()
        
        // Then the chess board view is visible
        let chessBoardView = chessBoardViewController.board
        XCTAssertNotNil(chessBoardView)
        XCTAssertTrue(chessBoardView.isKind(of: ChessBoardView.self))
    }

    func test_ChessBoardContains8x8Squares() {
        // Given the chess board view is visible
        let chessBoardViewController = ChessBoardViewController()
        chessBoardViewController.loadViewIfNeeded()
        if chessBoardViewController.board.isKind(of: ChessBoardView.self) != true {
            XCTFail()
            return
        }
        let chessBoard = Board()
        let squares = chessBoard.squares
        XCTAssert(squares.count == 8)
        let _ = squares.map { XCTAssert($0.count == 8) }

        // And the squares should alternate beteen white and black
        var row = 0
        var flagRow = 10
        for(_, item) in squares.enumerated() {
            // This is checking if the start of every row has repeated colour.
            let testLastSquareRowSameBlack = ((squares[row][0].color == .black) && flagRow == 0)
            let testLastSquareRowSameWhite = ((squares[row][0].color == .white) && flagRow == 1)
            if (testLastSquareRowSameBlack || testLastSquareRowSameWhite) {
                XCTFail()
                return
            }
            if (squares[row][0].color == .black) {
                flagRow = 0
            }
            if (squares[row][0].color == .white) {
                flagRow = 1
            }
            // Random value, because on the first square you don't have previous square so you don't have flag value as well.
            var flagFlank = 10
            var counter = 0
            for square in item {
                let testLastSquareSameBlack = ((square.color == .black) && flagFlank == 0)
                let testLastSquareSameWhite = ((square.color == .white) && flagFlank == 1)
                // This is checking if the the colour is repeated inside of every row.
                if(testLastSquareSameWhite || testLastSquareSameBlack) {
                     XCTFail()
                     return
                }
                if(square.color == .black) {
                     flagFlank = 0
                }
                if(square.color == .white) {
                     flagFlank = 1
                }
                counter += 1
             }
            row += 1
        }

        // And the bottom left square is black
        let bottomLeftSquare = squares[7][0]
        XCTAssert(bottomLeftSquare.color == .black)

        // And the bottom right square is white
        let bottomRightSquare = squares[7][7]
        XCTAssert(bottomRightSquare.color == .white)
    }

    func test_ChessBoardFillsInMaximumAvailableSpace() {
        let chessBoardViewController = ChessBoardViewController()
        chessBoardViewController.loadViewIfNeeded()
        let chessBoardView = chessBoardViewController.board
        let chessBoard = Board()

        var row = 0
        for(_, item) in chessBoard.squares.enumerated() {
             var counter = 0
             for square in item {
                 let SideSquare = chessBoardView.bounds.height / Double(ChessBoardView.squaresInRow)
                 if(SideSquare != square.sideOfSquare) {
                         XCTFail()
                         return
                 }
                 counter += 1
             }
            row += 1
        }
    }
    
    func testPiecesShownOnBoardView() {
        //Then they will see 8 pawns on the 2nd rank
        var engine = ChessEngine()
        engine.initialiseGame()
        let allpieces = engine.pieces
        var piecesOnThe2ndRank = [Piece]()
        piecesOnThe2ndRank = allpieces[1]
        XCTAssertTrue(piecesOnThe2ndRank.count == 8)
        
        let _ = piecesOnThe2ndRank.map {
            XCTAssertTrue($0.type == .pawn)
        }
        var piecesOnThe7ndRank = [Piece]()
        piecesOnThe7ndRank = allpieces[6]
        XCTAssertTrue(piecesOnThe7ndRank.count == 8)
        
        let _ = piecesOnThe7ndRank.map {
            XCTAssertTrue($0.type == .pawn)
        }
    }
    
        func testPawnMoves() {
            //   Given the user is on the board screen
            var chessEngine = ChessEngine()
            chessEngine.initialiseGame()//   And there is a pawn at the A2
            let pawn = Piece(type: .pawn, colour: .white, file: .A, rank: .second)
            //   When they tap the pawn A2
            //   Then the A3 and A4 squares on the board will be highlighted
            let validMovesA2 = chessEngine.possibleMoves(piece: pawn)
            XCTAssert((validMovesA2[0] == ("A", 3)) && (validMovesA2[1] == ("A", 4)))
            // And there is a black pawn at the F3
            let F3Pawn = Piece(type: .pawn, colour: .black, file: .F, rank: .third)
            // When they tap the pawn E2, and there is no pawn infront of E2
            // Then the E3, E4 and F3 squares on the board will be highlighted
            let E2Pawn = Piece(type: .pawn, colour: .white, file: .E, rank: .second)
            let validMovesE2 = chessEngine.possibleMoves(piece: E2Pawn)
            XCTAssert((validMovesE2[0] == ("E", 3)) && (validMovesE2[1] == ("E", 4)) && (validMovesE2[2] == ("F", 3)))
            // When they tap the pawn F2, and there is pawn infront of F2
            // Then the pawn on F2 have isn't capable of moving, has 0 squares
            let F2Pawn = Piece(type: .pawn, colour: .white, file: .F, rank: .second)
            let validMovesF2 = chessEngine.possibleMoves(piece: F2Pawn)
            XCTAssert(validMovesF2.isEmpty)
            // When they tap the pawn C2, they won't be able to take their white pawn on B3
            // Then the pawn on C2 will have 2 possible moves - to C3 and to C4
            let C2Pawn = Piece(type: .pawn, colour: .white, file: .C, rank: .second)
            let validMovesC2 = chessEngine.possibleMoves(piece: C2Pawn)
            XCTAssert((validMovesC2[0] == ("C", 3)) && (validMovesC2[1] == ("C", 4)))
            // When they tap the pawn F3
            // Then the black pawn on F3 will have 2 possible moves - to E2 and to G2
            let validMovesF3 = chessEngine.possibleMoves(piece: F3Pawn)
            XCTAssert((validMovesF3[0] == ("E", 2)) && (validMovesF3[1] == ("G", 2)))
        }
    
    func testRookMoves() {
        //   Given the user is on the board screen
        var chessEngine = ChessEngine()
        chessEngine.initialiseGame()//  And there is a white rook at the D4, white pawn at D2, and black pawn at D7
        let Wrook = Piece(type: .rook, colour: .white, file: .D, rank: .fourth)
        _ = Piece(type: .pawn, colour: .white, file: .D, rank: .second)
        _ = Piece(type: .pawn, colour: .white, file: .D, rank: .seventh)

        //   When they tap the rook D4
        //   Then the D5, D6, D7, D3, C4, B4, A4, E4, F4, G4 and H4 squares on the board will be highlighted
        let validMovesD4 = chessEngine.possibleMoves(piece: Wrook)
        XCTAssert((validMovesD4[0] == ("D", 5)) && (validMovesD4[1] == ("D", 6)) && (validMovesD4[2] == ("D", 7))) // Testing upper ranks
        XCTAssert(validMovesD4[3] == ("D", 3)) // Testing lower ranks
        XCTAssert((validMovesD4[4] == ("C", 4)) && (validMovesD4[5] == ("B", 4)) && (validMovesD4[6] == ("A", 4))) // Testing left files
        XCTAssert((validMovesD4[7] == ("E", 4)) && (validMovesD4[8] == ("F", 4)) && (validMovesD4[9] == ("G", 4)) && (validMovesD4[10] == ("H", 4))) // Testing right files
        
        //  And there is a black rook at the E5, white pawn at E2, and black pawn at E7
        let Brook = Piece(type: .rook, colour: .black, file: .E, rank: .fifth)
        _ = Piece(type: .pawn, colour: .white, file: .E, rank: .second)
        _ = Piece(type: .pawn, colour: .black, file: .E, rank: .seventh)

        //   When they tap the rook D4
        //   Then the D5, D6, D7, D3, C4, B4, A4, E4, F4, G4 and H4 squares on the board will be highlighted
        let validMovesE5 = chessEngine.possibleMoves(piece: Brook)
        XCTAssert(validMovesE5[0] == ("E", 6)) // Testing upper ranks
        XCTAssert((validMovesE5[1] == ("E", 4)) && (validMovesE5[2] == ("E", 3)) && (validMovesE5[3] == ("E", 2))) // Testing lower ranks
        XCTAssert((validMovesE5[4] == ("D", 5)) && (validMovesE5[5] == ("C", 5)) && (validMovesE5[6] == ("B", 5)) && (validMovesE5[7] == ("A", 5))) // Testing left files
        XCTAssert((validMovesE5[8] == ("F", 5)) && (validMovesE5[9] == ("G", 5)) && (validMovesE5[10] == ("H", 5))) // Testing right files
    }
}

