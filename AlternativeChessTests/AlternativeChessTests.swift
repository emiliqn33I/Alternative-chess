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
        XCTAssertTrue(chessBoardView.isKind(of:ChessBoardView.self))
    }

    func test_ChessBoardContains8x8Squares() {
        // Given the chess board view is visible
        let chessBoardViewController = ChessBoardViewController()
        chessBoardViewController.loadViewIfNeeded()
        if chessBoardViewController.board.isKind(of:ChessBoardView.self) != true {
            XCTFail()
            return
        }

        // Then the chess board contains a grid of 8x8 (64) squares
        let squares = chessBoardViewController.board.squares
        XCTAssert(squares.count == 8)
        let _ = squares.map { XCTAssert($0.count == 8) }
        
        // And the squares should alternate beteen white and black
        // TODO:
        var row = 0
        var flagRow = 10
        for(_, item) in squares.enumerated() {
            // This is checking if the start of every row have repeated colour.
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

        var row = 0
        for(_, item) in chessBoardView.squares.enumerated() {
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
}
