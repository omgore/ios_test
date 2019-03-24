//
//  ContentAPI.swift
//  ios_test
//
//  Created by Om Gore on 16/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import Foundation

protocol ContentAPI {
    func fetchContent(completion:@escaping (UserContentWrapper?, Error?) -> Void)
}

class UserContentAPI: ContentAPI {

    func fetchContent(completion: @escaping (UserContentWrapper?, Error?) -> Void) {
        BaseRestAPI.requestGETURL(Constants.jsonUrl) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let userWrapper = try JSONDecoder().decode(UserContentWrapper.self, from: data)
                completion(userWrapper, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
