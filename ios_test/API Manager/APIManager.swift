//
//  APIManager.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    func callJSONAPI(success : @escaping(UserContentWrapper) -> Void,
                     failure : @escaping(Error) -> Void)
    {
        BaseRestAPI.requestGETURL(JSON_URL, success: { (data) in
            let userWrapper = try? JSONDecoder().decode(UserContentWrapper.self, from: data)
            success(userWrapper!)
        }) { (error) in
            failure(error)
        }
    }
    
}
