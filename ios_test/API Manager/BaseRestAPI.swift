//
//  BaseRestAPI.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit
import Alamofire

class BaseRestAPI: NSObject {
    
    class func requestGETURL(_ strURL : String,
                             success:@escaping (Data) -> Void,
                             failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            
            switch response.result
            {
            case .success(_):
                let responseData = response.value?.data(using: .utf8)
                success(responseData!)
            case .failure((let error)):
                failure(error)
            }
            
        }
    }
}
