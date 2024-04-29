//
//  OLJSONParameterEncoder.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

public struct OLJSONParameterEncoder: OLParameterEncoder {

    public func encode(urlRequest: inout URLRequest, with parameters: OLParameters) throws {
        guard let parameters = parameters as? [String: Any] else {
            urlRequest.httpBody = (parameters as? String)?.data(using: .utf8)
            return
        }
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .withoutEscapingSlashes)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: OLNetworkConstants.contentType) == nil {
                urlRequest.setValue(OLNetworkConstants.applicationJson,
                                    forHTTPHeaderField: OLNetworkConstants.contentType)
            }
        } catch { throw OLNetworkError.encodingFailed }
    }
}
