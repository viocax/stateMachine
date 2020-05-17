//
//  UserCase.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import Combine
import Foundation

class UserCase {

    private let urlString: String

    init(_ urlString: String) {
        self.urlString = urlString
    }

    func fetchData<T: Codable>(_ model: T.Type) throws -> AnyPublisher<T, Error>  {
        guard let url = URL(string: urlString) else {
            throw LoadingState.ErrorCase.missURL
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError { $0 as Error }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
