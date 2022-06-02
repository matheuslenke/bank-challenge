//
//  NetworkClientMock.swift
//  BankChallengeAppTests
//
//  Created by Matheus Lenke on 01/06/22.
//

import Foundation
@testable import BankChallengeApp

final class NetworkClientMock: NetworkClientProtocol {
    
    enum Response {
        case success
        case successWithCustomJson(String)
        case error(HTTPRequestError)
    }
    
    var expectedResponse: Response = .success
    
    func performRequest(with request: Request, completion: @escaping Completion) {
        var json: String?
        let requestUrl = URL(string: request.baseURL)
        switch expectedResponse {
        case .success:
            json = Bundle(for: BankChallengeAppTests.self).path(forResource: self.getResourceName(url: requestUrl!),
                                                                ofType: "json")
        case .successWithCustomJson(let jsonFilename):
            json = Bundle(for: BankChallengeAppTests.self).path(forResource: jsonFilename, ofType: "json")
        case .error(let error):
            completion(.failure(error))
            return
        }

        guard let json = json else {
            completion(.failure(.couldNotParseResponse))
            return
        }

        let url = URL(fileURLWithPath: json)

        do {
            let newData = try Data(contentsOf: url)
            completion(.success(newData))
        } catch {
            completion(.failure(.couldNotParseResponse))
        }
    }

    private func getResourceName(url: URL) -> String {
        var resourceName = url.lastPathComponent
        resourceName = resourceName.components(separatedBy: ".")[0]
        return resourceName
    }
}
