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
    
    func testPieceShownOnBoardView() {
        //Then they will see 1 pawns on the 2nd rank
        var engine = ChessEngine()
        engine.initialiseGame()
        let allpieces = engine.pieces
        var piecesOnThe2ndRank = [Piece]()
        piecesOnThe2ndRank = allpieces.filter( { $0.position.rank == .second } )
        XCTAssertTrue(piecesOnThe2ndRank.count == 1)
        
        let _ = piecesOnThe2ndRank.map {
            XCTAssertTrue($0.type == .pawn)
        }
    }
    
    func testWhitePawnMoves2Squares() {
        //   Given the user is on the board screen
        var chessEngine = ChessEngine()
        chessEngine.initialiseGame()
        var board = Board()
        board.renewBoard()
        let allpieces = chessEngine.pieces
        //   And there is a pawn at the A2
        let pawnA2 = allpieces.filter{ $0.position.rank == .second && $0.position.file == .A}
        if (pawnA2.isEmpty) {
            XCTAssert(false)
        }
        
        //   When they tap the pawn A2
        //   Then the A3 and A4 squares on the board will be highlighted
        let validMovesA2 = chessEngine.possibleMoves(piece: pawnA2[0])
        print(validMovesA2[0])
        XCTAssert((validMovesA2[0].file == .A) && (validMovesA2[0].rank == .third) && (validMovesA2[1].file == .A) && (validMovesA2[1].rank == .fourth))
        
    }
    
    func testWhitePawnMoves1Squares() {
        //   Given the user is on the board screen
        var chessEngine = ChessEngine()
        chessEngine.initialiseGame()
        var board = Board()
        board.renewBoard()
        let allpieces = chessEngine.pieces
        //   And there is a pawn at the B3
        let pawnB3 = allpieces.filter{ $0.position.rank == .third && $0.position.file == .B}
        if (pawnB3.isEmpty) {
            XCTAssert(false)
        }
        //   And there is no pawn at B4
        let pawnB4 = allpieces.filter{ $0.position.rank == .fourth && $0.position.file == .B}
        if (pawnB4.isEmpty) {
        } else {
            XCTAssert(false)
        }
        //   When they tap the pawn B3
        //   Then the B4 squares on the board will be highlighted
        let validMovesB3 = chessEngine.possibleMoves(piece: pawnB3[0])
        XCTAssert(validMovesB3.count == 1)
        XCTAssert((validMovesB3[0].file == .B) && (validMovesB3[0].rank == .fourth))
    }
}

