//
//  UserContentViewModel.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

struct UserContentViewModel {
    let title:String
    let description:String
    let imageHref:String
    
    var isRowHeightZero = false
    
    init(objUserContent:UserContent) {
        
        if AppManager.sharedInstance.isEmptyString(string: objUserContent.title)
        {
            self.title = NO_TITLE
        }
        else
        {
            self.title = objUserContent.title!
        }
        
        if AppManager.sharedInstance.isEmptyString(string: objUserContent.description)
        {
            self.description = NO_SUBTITLE
        }
        else
        {
            self.description = objUserContent.description!
        }
        
        if AppManager.sharedInstance.isEmptyString(string: objUserContent.imageHref)
        {
            //for showing default placeholder
            self.imageHref = NO_IMGEREF
        }
        else
        {
            self.imageHref = objUserContent.imageHref!
        }
    }
    
}
