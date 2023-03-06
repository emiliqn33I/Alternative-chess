//
//  ChessBoardView.swift
//  AlternativeChess
//
//  Created by emo on 2.03.23.
//

import Foundation
import UIKit

protocol ChessBoardViewDelegate: AnyObject {
    func giveDuck() -> Piece?
    func checkMate() -> Bool
    func turn() -> Piece.Color
    func validMoves(for piece: Piece) -> [Position]
    func didMove(piece: Piece, to position: Position) -> Piece?
}

class ChessBoardView: UIView {
    static let squaresInRow = 8
    let board = Board()
    var pieces: [Piece] = []
    var pieceViews: [PieceView] = []
    var currentSelectedPiece: Piece?
    var validMoveViews: [UIView] = []
    var isCheckMate = 0
 
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
        
        if let selectedPiece = piece(at: tappedLocation) {
            if let delegate = delegate {
                if selectedPiece.colour == delegate.turn() {
                    currentSelectedPiece = selectedPiece
                    drawValidMoves(validMoves: delegate.validMoves(for: selectedPiece))
                }
            }
            if
                let chosenPosition = position(for: tappedLocation),
                let currentSelectedPiece = currentSelectedPiece {
                if let affectedPiece = delegate?.didMove(piece: currentSelectedPiece, to: chosenPosition) {
                    if affectedPiece.colour != currentSelectedPiece.colour {
                        pieceViewType(at: affectedPiece.position, color: affectedPiece.colour)!.removeFromSuperview()
                    }
                }
                
                updatePromotedPawnView(chosenPosition: chosenPosition)
            }
            
        } else if
            let chosenPosition = position(for: tappedLocation),
            let currentSelectedPiece = currentSelectedPiece {
            print("You have chosen to move \(currentSelectedPiece.type) to this position \(chosenPosition). ")
            if let affectedPiece = delegate?.didMove(piece: currentSelectedPiece, to: chosenPosition) {
                if affectedPiece.colour != currentSelectedPiece.colour {
                    pieceView(at: affectedPiece.position)!.removeFromSuperview()
                } else if affectedPiece.colour == currentSelectedPiece.colour {
                    pieceView(at: affectedPiece.position)!.setup(with: affectedPiece)
                }
            }
            
            updatePromotedPawnView(chosenPosition: chosenPosition)
        }
        
        if let delegate = delegate {
            if delegate.checkMate() == true {
                isCheckMate += 1
                checkMateView()
            }
        }
    }
    
    func checkMateView() {
        if isCheckMate == 1 {
            
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
    
    func updatePromotedPawnView(chosenPosition: Position) {
        if currentSelectedPiece!.type == .pawn && (chosenPosition.rank == .first || chosenPosition.rank == .eighth) {
            pieceView(at: chosenPosition)?.imageView!.removeFromSuperview()
            
            currentSelectedPiece!.type = .queen
            
            removeValidMoves()
            
            pieceView(at: chosenPosition)?.setupViewPicture(with: currentSelectedPiece!)
        } else {
            removeValidMoves()
            
            pieceView(at: chosenPosition)?.setup(with: currentSelectedPiece!)
        }
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

    func removeValidMoves() {
        for view in validMoveViews {
            view.removeFromSuperview()
        }
        validMoveViews.removeAll()
    }

    // MARK: Helpers

    private func piece(at point: CGPoint) -> Piece? {
        pieceViews.first { $0.frame.contains(point) }?.piece
    }
    
    private func pieceView(at position: Position) -> PieceView? {
        pieceViews.first { $0.piece.position == position }
    }
    
    private func pieceViewType(at position: Position, color: Piece.Color) -> PieceView? {
        pieceViews.first { $0.piece.position == position &&  $0.piece.colour == color }
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
