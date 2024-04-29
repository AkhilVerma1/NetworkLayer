//
//  OLRequestExecutor.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class OLRequestExecutor: NSObject, URLSessionDelegate {
    private var session: URLSession?
    private let apiTimeOut: Double = 90

    override init() {
        super.init()
        setup()
    }

    func execute(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do { return try await getSession().data(for: request) }
    }
}

private extension OLRequestExecutor {

    func setup() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForRequest = apiTimeOut

        session = URLSession(configuration: configuration,
                             delegate: self,
                             delegateQueue: nil)
    }

    func getSession() -> URLSession {
        session ?? URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
}
