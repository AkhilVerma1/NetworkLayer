//
//  OLParameterEncoding.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

public typealias OLParameters = Any?

protocol OLParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: OLParameters) throws
}

enum OLParameterEncoding {

    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding

    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: OLParameters?,
                       urlParameters: OLParameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try OLURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)

            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try OLJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)

            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                      let urlParameters = urlParameters else { return }
                try OLURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try OLJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        }
    }
}
