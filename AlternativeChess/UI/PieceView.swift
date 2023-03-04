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
    var imageView: UIImageView?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(piece: Piece, squareSide: CGFloat) {
        self.piece = piece
        self.squareSide = squareSide
        let frame = PieceView.rect(for: piece.position, squareSide: squareSide)
         
        super.init(frame: frame)
        let imageView = imageView(for: piece)
        self.imageView = imageView
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(imageView)
    }
    
    func setup(with piece: Piece) {
        let frame = PieceView.rect(for: piece.position, squareSide: squareSide)
        self.frame = frame
        self.piece = piece

    }
    
    func setupViewPicture(with piece: Piece) {
        let frame = PieceView.rect(for: piece.position, squareSide: squareSide)
        self.frame = frame
        self.piece = piece

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

