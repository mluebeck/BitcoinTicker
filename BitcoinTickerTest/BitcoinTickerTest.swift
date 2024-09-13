//
//  BitcoinTickerTest.swift
//  BitcoinTickerTest
//
//  Created by Mario Rotz on 12.09.24.
//

import XCTest
import BitcoinTicker



final class BitcoinTickerTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() throws {
        let (_,client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let (sut,client) = makeSUT()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
    
    private func makeSUT(url:URL = URL(string:"https://a-url.com")!) -> (sut:BitcoinDataLoader,client:HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = BitcoinDataLoader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy : HTTPClient {
        var requestedURL : URL?
        func get(from url:URL) {
            requestedURL = url
        }
    }
}
