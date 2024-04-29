//
//  ContentView.swift
//  NetworkLayer
//
//  Created by Akhil Verma on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    private let viewModel = ViewModel()
    var body: some View {
        VStack {
            Button("Fetch Users") {
                Task {
                    await viewModel.fetch()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//usage

class ViewModel {
    
    func fetch() async {
        let request = OLRequestType(baseURL: URL(string: "https://api.github.com")!,
                                    path: "users",
                                    httpMethod: .get,
                                    task: .request)

        let result = try? await OLAPIFetcher
            .init()
            .withAPI(request)
            .fetch(OLGithubTestResponseModel.self)
        
        debugPrint(result?.responseModel?.githubUsers.first?.id ?? 0)
    }
}

class OLGithubTestResponseModel: OLAPIResponse {
    var githubUsers: [OLGithubUserAPIModel] = []

    required init(_ response: Any?) {
        guard let response = response as? [[String: Any]] else { return }
        for user in response {
            githubUsers.append(OLGithubUserAPIModel(user))
        }
    }
}

class OLGithubUserAPIModel {
    var id: Int?
    var login: String?
    var nodeId: String?
    var avatarUrl: String?

    init(_ response: [String: Any]) {
        id = response["id"] as? Int
        login = response ["login"] as? String
        nodeId = response ["node_id"] as? String
        avatarUrl = response ["avatar_url"] as? String
    }
}
