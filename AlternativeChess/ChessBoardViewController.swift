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
    func validMoves(for piece: Piece) -> [Position] {
        return chessEngine.validMoves(for: piece)
    }

    func didMove(piece: Piece, to position: Position) {
        chessEngine.place(piece: piece, at: position)
    }
}

class PieceView: UIView {
    let piece: Piece
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

     static func rankReversed(rank: Position.Rank) -> Position.Rank {
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

protocol ChessBoardViewDelegate: AnyObject {
    func validMoves(for piece: Piece) -> [Position]
    func didMove(piece: Piece, to position: Position)
}

class ChessBoardView: UIView {
    static let squaresInRow = 8
    let board = Board()
    var pieces: [Piece] = []
    var pieceViews: [PieceView] = []
 
    weak var delegate: ChessBoardViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    var piece: Piece?
    @objc func didTapView(_ sender: UITapGestureRecognizer? = nil) {
        guard let gestureRecognizer = sender else {
            return
        }
        var aPiece = piece(at: gestureRecognizer.location(in: self))
        
        if let delegate = delegate {
            if aPiece != nil {
                piece = piece(at: gestureRecognizer.location(in: self))
                let validMoves = delegate.validMoves(for: piece!)
                drawValidMoves(validMoves: validMoves)
            }
        }
        var chosenSquareForPiece = validPosition(at: gestureRecognizer.location(in: self))
        
        if chosenSquareForPiece != nil {
            if let delegate = delegate {
                delegate.didMove(piece: piece!, to: chosenSquareForPiece!)
            }
        }
    }
    
    var validMoveViews: [UIView] = []

    func drawValidMoves(validMoves: [Position]) {
        let side = bounds.width / CGFloat(Position.File.allCases.count)

        for view in validMoveViews {
            view.removeFromSuperview()
        }
        validMoveViews.removeAll()
        
        for position in validMoves {
            let fileRaw = CGFloat(position.file.rawValue)
            let y = CGFloat(PieceView.rankReversed(rank: position.rank).rawValue) * side
            let validMoveView = UIView(frame: CGRect(x: fileRaw * side, y: y, width: side, height: side))
            validMoveView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            addSubview(validMoveView)
        
            validMoveViews.append(validMoveView)
        }
    }

    func piece(at point: CGPoint) -> Piece? {
        pieceViews.first { $0.frame.contains(point) }?.piece
    }
    
    func validPosition(at point: CGPoint) -> Position? {
        var selectedValidMove = validMoveViews.first { $0.frame.contains(point) }
        var file: Position.File?
        var rank: Position.Rank?
        
        if let width = selectedValidMove?.frame.width, let x = selectedValidMove?.frame.origin.x, let y = selectedValidMove?.frame.origin.y {
            let resultX = x / width
            let resultY = y / width
            
            for aFile in Position.File.allCases {
                if Int(resultX) == aFile.rawValue {
                    file = aFile
                }
            }
            
            for aRank in Position.Rank.allCases {
                if Int(resultY) == aRank.rawValue {
                    rank = PieceView.rankReversed(rank: aRank)
                }
            }
        }
        //print("This is the file of the valid move you have chosen \(file) and this is the rank \(rank) .")
        if file == nil || rank == nil {
            return nil
        }
        return Position(file: file!, rank: rank!)
    }

    override func draw(_ rect: CGRect) {
        drawBoard()
        drawPieces(pieces: pieces)
    }

    func drawPieces(pieces: [Piece]) {
        for piece in pieces {
            let pieceView = PieceView(piece: piece, squareSide: frame.width / 8)
            pieceViews.append(pieceView)
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
