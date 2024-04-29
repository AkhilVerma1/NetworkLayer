//
//  OLRequestType.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class OLRequestType {
    var baseURL: URL
    let path: String
    let httpMethod: OLHTTPMethod
    let task: OLHTTPTask
    let headers: OLHTTPHeaders?

    init(baseURL: URL, path: String, httpMethod: OLHTTPMethod, task: OLHTTPTask, headers: OLHTTPHeaders? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.task = task
        self.headers = headers
        self.httpMethod = httpMethod
    }
}
