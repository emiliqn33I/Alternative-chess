//
//  NetworkClient.swift
//  AlternativeChess
//
//  Created by emo on 3.05.23.
//

import Foundation
import ParseSwift

protocol NetworkClientDelegate: AnyObject {
    func networkClient(_ networkClient: NetworkClient, didReceiveNotation notation: String)
}

struct ChessGame: ParseObject {
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?

    var move: String?
}

class NetworkClient {
    weak var delegate: NetworkClientDelegate?

    init() {
        let chessGameQuery = ChessGame.query
        let subscribeCallback = chessGameQuery.subscribeCallback

        subscribeCallback?.handleSubscribe { subscribedQuery, isNew in
            if isNew {
                print("Successfully subscribed to new query \(subscribedQuery)")
            } else {
                print("Successfully updated subscription to new query \(subscribedQuery)")
            }
        }

        subscribeCallback?.handleEvent({ [weak self] query, event in
            guard let self = self else {
                return
            }
            print("Received new event: \(event)")
            switch event {
            case .created(let instance):
                guard let move = instance.move else {
                    return
                }
                self.delegate?.networkClient(self, didReceiveNotation: move)
                print("Received new gamechess instance: \(instance)")
            default:
                break
            }
        })
    }

    func send(moveNotation: String) {
        var chessGame = ChessGame()
        chessGame.move = moveNotation
        let publisher = chessGame.savePublisher()
    }
}
