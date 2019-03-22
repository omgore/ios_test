//
//  ContentAPI.swift
//  ios_test
//
//  Created by Om Gore on 16/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import Foundation

protocol ContentAPI {
    func fetchContent(success:@escaping ([UserContent], String) -> Void, failure : @escaping(UserContentError) -> Void )
}

enum UserContentError: String, Error {
    case emptyList = "User list is empty"
    case permissionDenied = "Permission Denied"
}

class UserContentAPI: ContentAPI {
    
    func fetchContent(success: @escaping ([UserContent], String) -> Void, failure: @escaping (UserContentError) -> Void) {
        BaseRestAPI.requestGETURL(Constants.jsonUrl, success: { (data) in
            
            do {
                let userWrapper = try JSONDecoder().decode(UserContentWrapper.self, from: data)
                
                guard let rows = userWrapper.rows else {
                    failure(UserContentError.emptyList)
                    return
                }
                
                success(rows, userWrapper.title!)
                
            } catch {
                failure(UserContentError(rawValue: error.localizedDescription)!)
            }
            
        }) { (error) in
            failure(UserContentError(rawValue: error.localizedDescription)!)
        }
    }
}
