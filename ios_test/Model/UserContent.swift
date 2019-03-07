//
//  UserContent.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

struct UserContent: Codable {
    
    let title:String?
    let description:String?
    let imageHref:String?
    
    enum CodingKeys:String,CodingKey
    {
        case title
        case description
        case imageHref
    }
    
}

struct UserContentWrapper: Codable {
    let title:String?
    let rows:[UserContent]?
    
    enum CodingKeys:String,CodingKey
    {
        case title
        case rows
    }
    
}
