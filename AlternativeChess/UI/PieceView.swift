//
//  PieceView.swift
//  AlternativeChess
//
//  Created by emo on 2.03.23.
//

import Foundation
import UIKit

class PieceView: UIView {
    var piece: Piece
    private let squareSide: CGFloat
    private var imageView: UIImageView

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(piece: Piece, squareSide: CGFloat) {
        self.piece = piece
        self.squareSide = squareSide
        let frame = PieceView.rect(for: piece.position, squareSide: squareSide)
        let padding: CGFloat = 5
        self.imageView = UIImageView(image: UIImage(named: piece.imageName))
        imageView.frame = CGRect(x: padding, y: padding, width: frame.width - (2 * padding), height: frame.height - (2 * padding))

        super.init(frame: frame)
        addSubview(imageView)
    }

    func setup(with piece: Piece) {
        let frame = PieceView.rect(for: piece.position, squareSide: squareSide)
        self.frame = frame
        self.piece = piece
    }

    func setup(with position: Position) {
        let frame = PieceView.rect(for: position, squareSide: squareSide)
        self.frame = frame
    }
    
    func setupViewImage(with piece: Piece) {
        self.piece = piece
        imageView.image = UIImage(named: piece.imageName)
    }

    private func imageView(for piece: Piece) -> UIImageView {
        UIImageView(image: UIImage(named: piece.imageName))
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

