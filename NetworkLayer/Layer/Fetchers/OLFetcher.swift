//
//  OLFetcher.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

protocol OLFetcher {
    var api: OLRequestType? { get set }
    var fetchMode: OLAPIMode { get set }

    func withAPI(_ api: OLRequestType) -> Self
    func setFetchMode(_ mode: OLAPIMode) -> Self

    func fetch<T: OLAPIResponse>(_ model: T.Type) async throws -> (responseModel: T?, error: String?)
}
