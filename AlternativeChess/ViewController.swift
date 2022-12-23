//
//  ViewController.swift
//  AlternativeChess
//
//  Created by Petar Bel on 15.12.22.
//

import UIKit

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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
