//
//  ViewController.swift
//  AlternativeChess
//
//  Created by Petar Bel on 15.12.22.
//

import UIKit

class ChessBoardViewController: UIViewController {
    @IBOutlet weak var boardView: ChessBoardView!
    let chessEngine: ChessEngine
    
    required init?(coder aDecoder: NSCoder) {
        let pieces = [Piece(.duck, .yellow, Position(file: .H, rank: .sixth)),
                      Piece(.pawn, .white, Position(file: .A, rank: .second)),
                      Piece(.pawn, .white, Position(file: .B, rank: .second)),
                      Piece(.pawn, .white, Position(file: .C, rank: .second)),
                      Piece(.pawn, .white, Position(file: .D, rank: .second)),
                      Piece(.pawn, .white, Position(file: .E, rank: .second)),
                      Piece(.pawn, .white, Position(file: .F, rank: .second)),
                      Piece(.pawn, .white, Position(file: .G, rank: .second)),
                      Piece(.pawn, .white, Position(file: .H, rank: .second)),
                      Piece(.rook, .white, Position(file: .A, rank: .first)),
                      Piece(.knight, .white, Position(file: .B, rank: .first)),
                      Piece(.bishop, .white, Position(file: .C, rank: .first)),
                      Piece(.queen, .white, Position(file: .D, rank: .first)),
                      Piece(.king, .white, Position(file: .E, rank: .first)),
                      Piece(.bishop, .white, Position(file: .F, rank: .first)),
                      Piece(.knight, .white, Position(file: .G, rank: .first)),
                      Piece(.rook, .white, Position(file: .H, rank: .first)),
                      Piece(.pawn, .black, Position(file: .A, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .B, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .C, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .D, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .E, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .F, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .G, rank: .seventh)),
                      Piece(.pawn, .black, Position(file: .H, rank: .seventh)),
                      Piece(.rook, .black, Position(file: .A, rank: .eighth)),
                      Piece(.knight, .black, Position(file: .B, rank: .eighth)),
                      Piece(.bishop, .black, Position(file: .C, rank: .eighth)),
                      Piece(.queen, .black, Position(file: .D, rank: .eighth)),
                      Piece(.king, .black, Position(file: .E, rank: .eighth)),
                      Piece(.bishop, .black, Position(file: .F, rank: .eighth)),
                      Piece(.knight, .black, Position(file: .G, rank: .eighth)),
                      Piece(.rook, .black, Position(file: .H, rank: .eighth))]
        chessEngine = ChessEngine(pieces: pieces, turn: .white)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView.pieces = chessEngine.pieces
        boardView.delegate = self
    }
}

extension ChessBoardViewController: ChessBoardViewDelegate {
    func checkMate() -> Bool {
        chessEngine.checkMate
    }
    
    func turn() -> Piece.Color {
        chessEngine.turn
    }
    
    func validMoves(for piece: Piece) -> [Position] {
        chessEngine.validMoves(for: piece)
    }

    func didMove(piece: Piece, to position: Position) -> Action {
        chessEngine.place(piece: piece, at: position)
    }
}
