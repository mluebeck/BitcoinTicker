//
//  BitcoinTickerTest.swift
//  BitcoinTickerTest
//
//  Created by Mario Rotz on 12.09.24.
//

import XCTest
import BitcoinTicker

class BitcoinDataLoader {
    let client : HTTPClient
    let url : URL
    init(url:URL = URL(string:"https://a-url.com")!,client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url:URL)
}

class HTTPClientSpy : HTTPClient {
    func get(from url:URL) {
        requestedURL = url
    }
    var requestedURL : URL?
}

final class BitcoinTickerTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() throws {
        let url = URL(string:"https://a-url.com")!
        let client = HTTPClientSpy()
        _ = BitcoinDataLoader(url:url,client: client)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string:"https://a-url.com")!
        let client = HTTPClientSpy()
        let sut = BitcoinDataLoader(url:url,client: client)
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}
