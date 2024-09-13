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
    static var shared = HTTPClient()
    var requestedURL : URL?
    func get(from url:URL) {}
}

class HTTPClientSpy : HTTPClient {
    override func get(from url:URL) {
        requestedURL = url
    }
}

final class BitcoinTickerTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() throws {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = BitcoinDataLoader()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = BitcoinDataLoader()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}
