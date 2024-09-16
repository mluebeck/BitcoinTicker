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
    
    public enum Error: Swift.Error {
        case connectivity
    }
    public init(url:URL,client: HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load(completion:@escaping (Error) -> Void) {
        client.get(from: url) {
            error in
            completion(.connectivity)
        }
    }
}

public protocol HTTPClient {
    func get(from url:URL, completion: @escaping (Error)->Void)
}
