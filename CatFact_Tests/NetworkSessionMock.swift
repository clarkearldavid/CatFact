//
//  NetworkSessionMock.swift
//  CatFact_Tests
//
//  Created by Clark David on 12/12/24.
//

import Foundation

class URLSessionMock: URLSession {
    var mockResponses: [String: String] = [:]
    var mockErrors: [String: Error] = [:]

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let mockResponse = mockResponses[url.absoluteString]
        let mockError = mockErrors[url.absoluteString]

        return URLSessionDataTaskMock {
            if let mockError = mockError {
                completionHandler(nil, nil, mockError)
            } else if let mockResponse = mockResponse {
                let data = mockResponse.data(using: .utf8)
                completionHandler(data, nil, nil)
            } else {
                completionHandler(nil, nil, NSError(domain: "UnknownMockError", code: 0, userInfo: nil))
            }
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
