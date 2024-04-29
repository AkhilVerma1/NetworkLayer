//
//  OLHTTPTask.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

typealias OLHTTPHeaders = [String: String]

enum OLHTTPTask {
    case request

    case requestParameters(bodyParameters: OLParameters?,
        bodyEncoding: OLParameterEncoding,
        urlParameters: OLParameters?)

    case requestParametersAndHeaders(bodyParameters: OLParameters?,
        bodyEncoding: OLParameterEncoding,
        urlParameters: OLParameters?,
        additionHeaders: OLHTTPHeaders?)
}
