//
//  BoardView.swift
//  Alternative_chess
//
//  Created by emo on 15.12.22.
//

import UIKit

class BoardView: UIView {

    override func draw(_ rect: CGRect) {
       drawBoard()
    }
    
    func drawBoard () {
        
        let path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 91, height: 91))
        path.fill()
    }

}
