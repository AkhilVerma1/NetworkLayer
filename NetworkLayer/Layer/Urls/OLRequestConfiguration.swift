//
//  OLRequestConfiguration.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 25/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class OLRequestConfiguration {
    static let shared = OLRequestConfiguration()
    private var configurations: [OLRequests: OLRequestType] = [:]

    private init() {
        configurations[.github] = getGithubConfiguration()
    }

    func getConfiguration(_ request: OLRequests) -> OLRequestType? {
        configurations[request]
    }
}

private extension OLRequestConfiguration {

    func getGithubConfiguration() -> OLRequestType {
        OLRequestType(baseURL: OLURL.shared.getBaseURL(),
                      path: "users",
                      httpMethod: .get,
                      task: .request)
    }
}
