//
//  OLNetworkManager.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class OLNetworkManager {

    func request<T: OLAPIResponse>(_ endPoint: OLRequestType?) async throws -> (responseModel: T?, error: String?) {
        guard let endPoint = endPoint else { return (nil, "Endpoint is invalid") }
        do {
            let (data, response) = try await OLRouter.init().request(endPoint)
            return handleAPIResponse(T.self, data: data, response: response)
        }
    }
}

private extension OLNetworkManager {

    func getAPIModel<T: OLAPIResponse>(_ model: T.Type, responseData: Data) -> T {
        T.init(try? JSONSerialization.jsonObject(with: responseData))
    }

    func getAPIError(_ data: Data?) -> String? {
        guard let data = data else { return nil }
        guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any],
                let errorMessage = jsonData[OLNetworkConstants.reason] else { return nil }

        return errorMessage as? String
    }

    func handleAPIResponse<T: OLAPIResponse>(_ model: T.Type, data: Data?, response: URLResponse?) -> (T?, String?) {
        guard let response = response as? HTTPURLResponse
        else { return (nil, OLNetworkConstants.checkNetworkConnection) }

        switch handleNetworkResponse(response) {
        case .success:
            guard let responseData = data else { return (nil, OLNetworkResponse.noData.rawValue) }
            return (getAPIModel(T.self, responseData: responseData), nil)

        case.failure(let networkFailureError):
            debugPrint("OCloudLabs-API error: \(getAPIError(data) ?? "")")
            return (nil, networkFailureError)
        }
    }

    func handleNetworkResponse(_ response: HTTPURLResponse) -> OLResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(OLNetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(OLNetworkResponse.badRequest.rawValue)
        case 600: return .failure(OLNetworkResponse.outdated.rawValue)
        default: return .failure(OLNetworkResponse.failed.rawValue)
        }
    }
}
