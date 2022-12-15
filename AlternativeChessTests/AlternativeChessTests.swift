//
//  AlternativeChessTests.swift
//  AlternativeChessTests
//
//  Created by Petar Bel on 15.12.22.
//

import XCTest
@testable import AlternativeChess

class ChessBoardViewController: UIViewController {
    
    // Aproach 1 - where UIVieController's view is of our type
//    override func loadView() {
//        view = ChessBoardView()
//    }

    // Approach 2 - where UIVieController's view subview is of our type
    override func viewDidLoad() {
        let chessBoardView = ChessBoardView()
        view.addSubview(chessBoardView)
    }
}

struct Square {
    enum Color {
        case white
        case black
    }
    let color: Color
}

class ChessBoardView: UIView {
    private static let squaresInRow = 8

    let squares: [[Square]] = {
        var board: [[Square]] = []
        for row in 0 ..< ChessBoardView.squaresInRow {
            board.append([])
            for column in 0 ..< ChessBoardView.squaresInRow {
                let squareColor: Square.Color = (row + column).isMultiple(of: 2) ? .black : .white
                board[row].append(Square(color: squareColor))
            }
        }
        return board
    }()

    override func draw(_ rect: CGRect) {
        // TODO: draw squares in rect
    }
}

final class AlternativeChessTests: XCTestCase {
    func test_ChessBoardViewControllerContainsChessView() {
        // Given the app is launched
        // When the user navigates to the chess board view
        let chessBoardViewController = ChessBoardViewController()
        chessBoardViewController.loadViewIfNeeded()
        
        // Then the chess board view is visible
        let chessBoardView = chessBoardViewController.view.subviews.first
        XCTAssertNotNil(chessBoardView)
        XCTAssertTrue(chessBoardView!.isKind(of: ChessBoardView.self))
    }

    func test_ChessBoardContains8x8Squares() {
        // Given the chess board view is visible
        let chessBoardViewController = ChessBoardViewController()
        chessBoardViewController.loadViewIfNeeded()
        guard let chessBoardView: ChessBoardView = chessBoardViewController.view.subviews.first as? ChessBoardView else {
            XCTFail()
            return
        }

        // Then the chess board contains a grid of 8x8 (64) squares
        let squares = chessBoardView.squares
        XCTAssert(squares.count == 8)
        let _ = squares.map { XCTAssert($0.count == 8) }
        
        // And the squares should alternate beteen white and black
        // TODO:
        
        // And the bottom left square is white
        let bottomLeftSquare = squares[7][0]
        XCTAssert(bottomLeftSquare.color == .white)

        // And the bottom right square is black
        let bottomRightSquare = squares[7][7]
        XCTAssert(bottomRightSquare.color == .black)
    }

//    func test_ChessBoardFillsInMaximumAvailableSpace() {
//    }
}
