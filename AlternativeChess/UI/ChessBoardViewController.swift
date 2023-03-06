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
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .B, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .C, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .D, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .E, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .F, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .G, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .H, rank: .second)),
                      Piece(type: .rook, colour: .white, position: Position(file: .A, rank: .first)),
                      Piece(type: .knight, colour: .white, position: Position(file: .B, rank: .first)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .C, rank: .first)),
                      Piece(type: .queen, colour: .white, position: Position(file: .D, rank: .first)),
                      Piece(type: .king, colour: .white, position: Position(file: .E, rank: .first)),
                      Piece(type: .bishop, colour: .white, position: Position(file: .F, rank: .first)),
                      Piece(type: .knight, colour: .white, position: Position(file: .G, rank: .first)),
                      Piece(type: .rook, colour: .white, position: Position(file: .H, rank: .first)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .A, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .B, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .C, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .D, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .E, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .F, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .G, rank: .seventh)),
                      Piece(type: .pawn, colour: .black, position: Position(file: .H, rank: .seventh)),
                      Piece(type: .rook, colour: .black, position: Position(file: .A, rank: .eighth)),
                      Piece(type: .knight, colour: .black, position: Position(file: .B, rank: .eighth)),
                      Piece(type: .bishop, colour: .black, position: Position(file: .C, rank: .eighth)),
                      Piece(type: .queen, colour: .black, position: Position(file: .D, rank: .eighth)),
                      Piece(type: .king, colour: .black, position: Position(file: .E, rank: .eighth)),
                      Piece(type: .bishop, colour: .black, position: Position(file: .F, rank: .eighth)),
                      Piece(type: .knight, colour: .black, position: Position(file: .G, rank: .eighth)),
                      Piece(type: .rook, colour: .black, position: Position(file: .H, rank: .eighth))]
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

    func didMove(piece: Piece, to position: Position) -> Action? {
        chessEngine.place(piece: piece, at: position)
    }
}
