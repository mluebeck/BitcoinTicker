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
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs,[url])
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let url = URL(string:"https://a-given-url.com")!
        let (sut,client) = makeSUT(url:url)
        sut.load { _ in }
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs,[url,url])
    }
    
    func test_load_deliversErrorOnClientError(){
        let (sut,client) = makeSUT()
        expect(sut, toCompleteWithError: .connectivity, when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse(){
        let (sut,client) = makeSUT()
        let samples = [199,201,300,400,500]
        samples.enumerated().forEach { index,code in
            expect(sut, toCompleteWithError: .invalidData, when: {
                client.complete(withStatusCode: code, at:index)
            })
        }
    }
    
    func test_load_deliversErrorOnNon200HTTPResponseWithInvalidJSON(){
        let (sut,client) = makeSUT()
        expect(sut, toCompleteWithError: .invalidData, when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data:invalidJSON)
        })
    }
    
    
    //MARK: - Helper methods
    
    private func makeSUT(url:URL = URL(string:"https://a-url.com")!) -> (sut:BitcoinDataLoader,client:HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = BitcoinDataLoader(url: url, client: client)
        return (sut,client)
    }
    
    private func expect(_ sut:BitcoinDataLoader, toCompleteWithError error: BitcoinDataLoader.Error, when action: () -> Void, file:StaticString = #filePath, line: UInt = #line)
    {
        var capturedErrors = [BitcoinDataLoader.Error]()
        sut.load {
            capturedErrors.append($0)
        }
        action()
        XCTAssertEqual(capturedErrors,[error],file:file,line:line)
    }
    
    private class HTTPClientSpy : HTTPClient {
         
        private var messages = [(url:URL,completion:(HTTPClientResult)->Void)]()
        var requestedURLs : [URL]
        {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion:@escaping (HTTPClientResult) -> Void) {
            messages.append((url:url,completion:completion))
        }
        
        func complete(with error:Error, at index:Int=0) {
            messages[index].completion(HTTPClientResult.failure(error))
        }
        
        func complete(withStatusCode code:Int,data:Data = Data(), at index:Int = 0) {
            let response = HTTPURLResponse( url: requestedURLs[index],
                                            statusCode: code,
                                            httpVersion: nil,
                                            headerFields: nil)!
            messages[index].completion(.success(data,response))
        }
    }
}
