//
//  HelperClass.swift
//  AlternativeChess
//
//  Created by emo on 13.02.23.
//

import Foundation

class Helper {
    func reverse(colour: Piece.Color) -> Piece.Color {
        if colour == .white {
            return .black
        }
        if colour == .black {
            return .white
        }
        return .white
    }
    
    func validatingMoves(possibleMoves: [Position], kingCheckMoves: [Position]) -> [Position] {
        var validMoves = [Position]()
        
        for move in possibleMoves {
            var flag = true
            
            for moveCheck in kingCheckMoves {
                if move == moveCheck {
                    flag = false
                }
            }
            
            if flag {
                validMoves.append(move)
            }
        }
        return validMoves
    }
    
    func removePositionFromValidMoves(validMoves: [Position], position: Position) -> [Position] {
        var validMovesArray = validMoves
        
        for move in validMovesArray {
            if move == position {
                if let index = validMovesArray.firstIndex(of: move) {
                    validMovesArray.remove(at: index)
                }
            }
        }
        return validMovesArray
    }
    
    func upperOrLower(direction: Bool) -> [Int] {
        var array = [Int]()
        
        if direction {
            array.append(1)
            array.append(7)
        } else {
            array.append(-1)
            array.append(0)
        }
        
        return array
    }
    
    func giveFileOrRank(type: Bool, piece: Piece) -> Int {
        if type {
            return piece.position.file.rawValue
        } else {
            return piece.position.rank.rawValue
        }
    }
    
    func incrementRankOrFile(type: Bool, incrementWith: Int, rookPosition: Int) -> [Int] {
        var array = [Int]()
        
        if type {
            array.append(incrementWith + 1)
            array.append(rookPosition + 1)
        } else {
            array.append(incrementWith - 1)
            array.append(rookPosition - 1)
        }
        
        return array
    }
    
    func incrementRankAndFile(file: Bool, rank: Bool, incrementFile: Int, incrementRank: Int) -> [Int] {
        var array = [Int]()
        
        if file && rank {
            array.append(incrementFile + 1)
            array.append(incrementRank + 1)
        }
        if file && (rank == false) {
            array.append(incrementFile + 1)
            array.append(incrementRank - 1)
        }
        if (file == false) && rank {
            array.append(incrementFile - 1)
            array.append(incrementRank + 1)
        }
        if (file == false) && (rank == false) {
            array.append(incrementFile - 1)
            array.append(incrementRank - 1)
        }
        
        return array
    }
    
    func incrementRankAndFileKnight(file: Bool, rank: Bool, incrementFile: Int, incrementRank: Int) -> [Int] {
        var array = [Int]()
        
        if file && rank {
            array.append(incrementFile + 1)
            array.append(incrementRank + 2)
            array.append(incrementFile + 2)
            array.append(incrementRank + 1)
        }
        if file && (rank == false) {
            array.append(incrementFile + 1)
            array.append(incrementRank - 2)
            array.append(incrementFile + 2)
            array.append(incrementRank - 1)
        }
        if (file == false) && rank {
            array.append(incrementFile - 1)
            array.append(incrementRank + 2)
            array.append(incrementFile - 2)
            array.append(incrementRank + 1)
        }
        if (file == false) && (rank == false) {
            array.append(incrementFile - 1)
            array.append(incrementRank - 2)
            array.append(incrementFile - 2)
            array.append(incrementRank - 1)
        }
        
        return array
    }
    
    func checkIsEmpty(positions: [Position]) -> Bool {
        return positions.isEmpty
    }
}
