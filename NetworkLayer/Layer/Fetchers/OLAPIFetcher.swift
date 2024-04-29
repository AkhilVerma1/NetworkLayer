//
//  OLAPIFetcher.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class OLAPIFetcher: OLFetcher {
    var api: OLRequestType?
    var fetchMode: OLAPIMode = .online

    func withAPI(_ api: OLRequestType) -> Self {
        self.api = api
        return self
    }

    func setFetchMode(_ mode: OLAPIMode) -> Self {
        fetchMode = mode
        return self
    }

    func fetch<T>(_ model: T.Type) async throws -> (responseModel: T?, error: String?) where T: OLAPIResponse {
        do {
            return try await OLNetworkManager.init().request(api)
        } catch {
            return (nil, OLNetworkResponse.failed.rawValue)
        }
    }
}
