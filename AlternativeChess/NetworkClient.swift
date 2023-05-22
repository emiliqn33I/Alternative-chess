//
//  NetworkClient.swift
//  AlternativeChess
//
//  Created by emo on 3.05.23.
//

import Foundation

protocol NetworkClientDelegate: AnyObject {
    func networkClient(_ networkClient: NetworkClient, didReceiveNotation notation: String)
}

class NetworkClient {

}
