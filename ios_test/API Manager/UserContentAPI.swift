//
//  ContentAPI.swift
//  ios_test
//
//  Created by Om Gore on 16/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import Foundation

protocol ContentAPI {
    func fetchContent(params:[String:String], success:@escaping ([UserContent], String)-> Void, failure : @escaping(Error) -> Void )
}

enum UserContentError : Error {
    case EmptyList
    
    var localizedDescription: String {
        switch self {
        case .EmptyList :
            return "User list is empty"
        }
    }
}

class UserContentAPI : ContentAPI {
    
    func fetchContent(params: [String : String], success: @escaping ([UserContent], String) -> Void, failure: @escaping (Error) -> Void) {
        BaseRestAPI.requestGETURL(JSON_URL, success: { (data) in
            
            do {
                let userWrapper = try JSONDecoder().decode(UserContentWrapper.self, from: data)
                
                guard let rows = userWrapper.rows else {
                    failure(UserContentError.EmptyList)
                    return
                }
                
                success(rows, userWrapper.title!)
                
            } catch {
                failure(error)
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
