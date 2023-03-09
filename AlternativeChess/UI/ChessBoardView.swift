//
//  ChessBoardView.swift
//  AlternativeChess
//
//  Created by emo on 2.03.23.
//

import Foundation
import UIKit

protocol ChessBoardViewDelegate: AnyObject {
    func checkMate() -> Bool
    func turn() -> Piece.Color
    func validMoves(for piece: Piece) -> [Position]
    func didMove(piece: Piece, to position: Position) -> Action
}

class ChessBoardView: UIView {
    static let squaresInRow = 8
    let board = Board()
    var pieces: [Piece] = []
    var pieceViews: [PieceView] = []
    var currentSelectedPiece: Piece?
    var validMoveViews: [UIView] = []
    var isCheckMate = false
    var pieceMoved = false
 
    weak var delegate: ChessBoardViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }

    override func draw(_ rect: CGRect) {
        drawBoard()
        drawPieces(pieces: pieces)
    }

    // MARK: UI Action Events

    @objc private func didTapView(_ sender: UITapGestureRecognizer? = nil) {
        guard let gestureRecognizer = sender else {
            return
        }
        let tappedLocation = gestureRecognizer.location(in: self)
        
        if pieceMoved {
            if let selectedPiece = piece(at: tappedLocation) {
                // Case 1 - User has tapped on duck initially
                if let delegate = delegate, selectedPiece.colour == .yellow {
                    print("You have chosen \(selectedPiece)")
                    currentSelectedPiece = selectedPiece
                    drawValidMoves(validMoves: delegate.validMoves(for: selectedPiece))
                }
            } else if
                // Case 2 - User has selected duck and has tapped on a square to place the duck
                let chosenPosition = position(for: tappedLocation),
                let currentSelectedPiece = currentSelectedPiece {
                performPlacingOnASquareWithoutPiece(for: chosenPosition, currentSelectedPiece: currentSelectedPiece)
                pieceMoved = false
            }
        } else {
            if let selectedPiece = piece(at: tappedLocation) {
                // Case 1 - User has tapped on a piece initially
                if let delegate = delegate, selectedPiece.colour == delegate.turn() {
                    print("You have chosen \(selectedPiece)")
                    currentSelectedPiece = selectedPiece
                    drawValidMoves(validMoves: delegate.validMoves(for: selectedPiece))
                } else if
                    // Case 2 - User has selected a piece and has tapped on a square with another piece
                    let chosenPosition = position(for: tappedLocation),
                    let currentSelectedPiece = currentSelectedPiece {
                    performPlacingOnASquareWithPiece(for: currentSelectedPiece, and: chosenPosition)
                    pieceMoved = true
                }
            } else if
                // Case 3 - User has selected a piece and has tapped on a square without a piece
                let chosenPosition = position(for: tappedLocation),
                let currentSelectedPiece = currentSelectedPiece {
                performPlacingOnASquareWithoutPiece(for: chosenPosition, currentSelectedPiece: currentSelectedPiece)
                pieceMoved = true
            }
        }

        if let delegate = delegate, delegate.checkMate() {
            isCheckMate = true
            checkMateView()
        }
    }

    private func performPlacingOnASquareWithPiece(for piece: Piece, and position: Position) {
        // Get the affected piece view and remove it from screen
        guard let pieceMoveAction = delegate?.didMove(piece: piece, to: position) else {
            return
        }
        switch pieceMoveAction.moveType {
        case .take:
            performTake(for: pieceMoveAction.piece, currentSelectedPiece: piece)
        case .promotion:
            performPromotion(for: pieceMoveAction.piece, currentSelectedPiece: piece, takeOrMovePromotion: true)
        default:
            return
        }
    }

    private func performPlacingOnASquareWithoutPiece(for position: Position, currentSelectedPiece: Piece) {
        guard let pieceMoveAction = delegate?.didMove(piece: currentSelectedPiece, to: position) else {
            return
        }
        switch pieceMoveAction.moveType {
        case .castle:
            if pieceMoveAction.piece.colour == currentSelectedPiece.colour {
                pieceView(at: pieceMoveAction.piece.position)?.setup(with: pieceMoveAction.piece)
                performAfterPlacement(for: currentSelectedPiece, and: position)
            }
        case .promotion:
            performPromotion(for: pieceMoveAction.piece, currentSelectedPiece: currentSelectedPiece, takeOrMovePromotion: false)
        case .enPassant:
            pieceView(at: pieceMoveAction.piece.position)!.removeFromSuperview()
            if let affectedPieceView = pieceView(at: pieceMoveAction.piece.position) {
                if let index = pieceViews.firstIndex(of: affectedPieceView) {
                    pieceViews.remove(at: index)
                }
            }
            performAfterPlacement(for: currentSelectedPiece, and: position)
        case .move:
            performAfterPlacement(for: currentSelectedPiece, and: position)
        default:
            return
        }
    }

    private func performAfterPlacement(for piece: Piece, and position: Position) {
        removeValidMoves()
        pieceView(at: position)?.setup(with: piece)
    }

    private func performTake(for piece: Piece, currentSelectedPiece: Piece) {
        if let affectedView = pieceView(for: piece) {
            affectedView.removeFromSuperview()
            if let index = pieceViews.firstIndex(of: affectedView) {
                pieceViews.remove(at: index)
            }
        }

        removeValidMoves()

        pieceView(for: currentSelectedPiece)?.setup(with: piece.position)
    }

    private func performPromotion(for piece: Piece, currentSelectedPiece: Piece, takeOrMovePromotion: Bool) {
        guard let affectedPieceView = pieceView(for: piece) else {
            return
        }
        if takeOrMovePromotion {
            affectedPieceView.removeFromSuperview()
            if let index = pieceViews.firstIndex(of: affectedPieceView) {
                pieceViews.remove(at: index)
            }
        }
        removeValidMoves()
        pieceView(at: piece.position)?.setupViewImage(with: currentSelectedPiece)
    }

    // MARK: Drawing

    private func drawValidMoves(validMoves: [Position]) {
        let side = bounds.width / CGFloat(Position.File.allCases.count)

        removeValidMoves()

        for position in validMoves {
            let fileRaw = CGFloat(position.file.rawValue)
            let y = CGFloat(PieceView.rankReversed(rank: position.rank).rawValue) * side
            let validMoveView = UIView(frame: CGRect(x: fileRaw * side, y: y, width: side, height: side))
            validMoveView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            addSubview(validMoveView)
        
            validMoveViews.append(validMoveView)
        }
    }

    private func drawPieces(pieces: [Piece]) {
        for piece in pieces {
            let pieceView = PieceView(piece: piece, squareSide: frame.width / 8)
            pieceViews.append(pieceView)
            addSubview(pieceView)
        }
    }

    private func drawBoard() {
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

    private func removeValidMoves() {
        for view in validMoveViews {
            view.removeFromSuperview()
        }
        validMoveViews.removeAll()
    }

    private func checkMateView() {
        if isCheckMate {

            let checkMateOverlay = UIView(frame: bounds)
            checkMateOverlay.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)

            let label = UILabel()
            label.text = "Checkmate"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 40)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            checkMateOverlay.addSubview(label)

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: checkMateOverlay.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: checkMateOverlay.centerYAnchor)
            ])

            addSubview(checkMateOverlay)
        }
    }

    // MARK: Helpers

    private func piece(at point: CGPoint) -> Piece? {
        pieceViews.first { $0.frame.contains(point) }?.piece
    }
    
    private func pieceView(at position: Position) -> PieceView? {
        pieceViews.first { $0.piece.position == position }
    }

    private func pieceView(for piece: Piece) -> PieceView? {
        pieceViews.first { $0.piece == piece }
    }
    
    private func position(for point: CGPoint) -> Position? {
        let selectedValidMove = validMoveViews.first { $0.frame.contains(point) }
        var file: Position.File?
        var rank: Position.Rank?
        
        if
            let width = selectedValidMove?.frame.width,
            let x = selectedValidMove?.frame.origin.x,
            let y = selectedValidMove?.frame.origin.y {
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
        guard
            let file = file,
            let rank = rank else {
            return nil
        }
        return Position(file: file, rank: rank)
    }
}
