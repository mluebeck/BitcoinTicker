//
//  main.swift
//  BitcoinTicker
//
//  Created by Mario Rotz on 12.09.24.
//

import Foundation
 
public final class BitcoinDataLoader {
    private let client : HTTPClient
    private let url : URL
    public init(url:URL,client: HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load() {
        client.get(from: url)
    }
}

public protocol HTTPClient {
    func get(from url:URL)
}
