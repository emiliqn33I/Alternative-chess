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
        let pieces = [Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .first)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .second)),
                      Piece(type: .pawn, colour: .white, position: Position(file: .A, rank: .third))]
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
            imageName = ""
        case .bishop:
            imageName = ""
        case .knight:
            imageName = ""
        case .queen:
            imageName = ""
        case .king:
            imageName = ""
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
