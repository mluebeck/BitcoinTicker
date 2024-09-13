//
//  BitcoinTickerTest.swift
//  BitcoinTickerTest
//
//  Created by Mario Rotz on 12.09.24.
//

import XCTest
import BitcoinTicker

class BitcoinDataLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string:"https://a-url.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    var requestedURL : URL?
}

final class BitcoinTickerTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() throws {
        let client = HTTPClient.shared
        _ = BitcoinDataLoader()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = BitcoinDataLoader()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}
