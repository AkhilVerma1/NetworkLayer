//
//  OLURL.swift
//  OCloudLabs
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class OLURL {
    static let shared = OLURL()
    private let security = "https://"
    private var infoDict: [String: Any] = Bundle.main.infoDictionary ?? [:]

    private init() {
        // private init
    }

    func getBaseURL() -> URL {
        let url = "\(security)\(getServerURL())"
        return URL(string: url) ?? URL(fileURLWithPath: "")
    }
}

private extension OLURL {
    func getServerURL() -> String {
        guard let baseURL = infoDict[OLPlistKey.serverURL.rawValue] as? String else { return "" }
        let cleanURL = baseURL.replacingOccurrences(of: "\"", with: "")
        return cleanURL
    }
}

enum OLPlistKey: String {
    case serverURL = "BASE_URL"
}
