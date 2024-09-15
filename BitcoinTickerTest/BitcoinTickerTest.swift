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
        let url = URL(string:"https://a-given-url.com")!
        let (_,client) = makeSUT(url: url)
        XCTAssertEqual(client.requestedURLs,[])
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string:"https://a-given-url.com")!
        let (sut,client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURLs,[url])
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let url = URL(string:"https://a-given-url.com")!
        let (sut,client) = makeSUT(url:url)
        sut.load()
        sut.load()
        XCTAssertEqual(client.requestedURLs,[url,url])
    }
    
    func test_load_deliversErrorOnClientError(){
        let (sut,client) = makeSUT()
        client.error = NSError(domain: "Test", code: 0)
        var capturedError : BitcoinDataLoader.Error?
        
        sut.load {
            error in
            capturedError = error
        }
        XCTAssertEqual(capturedError,.connectivity)
    }
    
    
    //MARK: - Helper methods
    
    private func makeSUT(url:URL = URL(string:"https://a-url.com")!) -> (sut:BitcoinDataLoader,client:HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = BitcoinDataLoader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy : HTTPClient {
        
        
        var requestedURLs = [URL]()
        var error : Error?
        func get(from url: URL, completion: (any Error) -> Void) {
            if let error = error {
                completion(error)
            }
            requestedURLs.append(url)
        }
    }
}
