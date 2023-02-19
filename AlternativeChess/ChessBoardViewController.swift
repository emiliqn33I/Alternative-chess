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
    }
    
    // TODO:
    func didTap(piece: Piece) {
        let validMoves = chessEngine.validMoves(for: piece)
    }

}

class PieceView: UIView {
    private let piece: Piece
    private let squareSide: CGFloat

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(piece: Piece, squareSide: CGFloat) {
        self.piece = piece
        self.squareSide = squareSide
        let frame = PieceView.rect(for: piece.position, squareSide: squareSide)
         
        super.init(frame: frame)
        let imageView = imageView(for: piece)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(imageView)
    }

    private func imageView(for piece: Piece) -> UIImageView {
        var imageName: String = ""
        switch piece.type {
        case .pawn:
            imageName = piece.colour == .white ? "w_pawn" : "b_pawn"
        case .rook:
            imageName = piece.colour == .white ? "w_rook" : "b_rook"
        case .bishop:
            imageName = piece.colour == .white ? "w_bishop" : "b_bishop"
        case .knight:
            imageName = piece.colour == .white ? "w_knight" : "b_knight"
        case .queen:
            imageName = piece.colour == .white ? "w_queen" : "b_queen"
        case .king:
            imageName = piece.colour == .white ? "w_king" : "b_king"
        }
        let imageView = UIImageView(image: UIImage(named: imageName))
        return imageView
    }
    
    private static func rect(for position: Position, squareSide: CGFloat) -> CGRect {
        let fileRaw = CGFloat(position.file.rawValue)
        let y = CGFloat(PieceView.rankReversed(rank: position.rank).rawValue) * squareSide
        return CGRect(x: fileRaw * squareSide, y: y, width: squareSide, height: squareSide)
    }

    private static func rankReversed(rank: Position.Rank) -> Position.Rank {
        switch rank {
        case .first:
            return .eighth
        case .second:
            return .seventh
        case .third:
            return .sixth
        case .fourth:
            return .fifth
        case .fifth:
            return .fourth
        case .sixth:
            return .third
        case .seventh:
            return .second
        case .eighth:
            return .first
        }
    }
}

class ChessBoardView: UIView {
    static let squaresInRow = 8
    let board = Board()
    var pieces: [Piece] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        drawBoard()
        drawPieces(pieces: pieces)
    }

    func drawPieces(pieces: [Piece]) {
        for piece in pieces {
            let pieceView = PieceView(piece: piece, squareSide: frame.width / 8)
            addSubview(pieceView)
        }
    }

    func drawBoard() {
        let side = bounds.width / CGFloat(ChessBoardView.squaresInRow)
        var row = 0
        
        for(_, item) in board.squares.enumerated() {
            var counter = 0
            for square in item {
                let path = UIBezierPath(rect: CGRect(x: CGFloat(counter) * side, y: CGFloat(row) * side, width: side, height: side))
                if (square.color == .white) {
                    let blackColor = UIColor.white
                    blackColor.setStroke()
                    UIColor.white.setFill()
                    path.fill()
                } else {
                    let blackColor = UIColor.black
                    blackColor.setStroke()
                    UIColor.black.setFill()
                    path.fill()
                }
                counter += 1
            }
            row += 1
        }
    }
}
