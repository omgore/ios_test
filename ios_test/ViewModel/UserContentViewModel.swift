//
//  ContentViewModel.swift
//  ios_test
//
//  Created by Om Gore on 16/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit
import Foundation

class UserContentViewModel: NSObject {
    
    var showLoading : Observable<Bool>
    var showError : Observable<String>
    var contentList : Observable<[CellViewModel]>
    var service : ContentAPI
    var navTitle : String
    
    init(content : [UserContent], service : ContentAPI, title : String) {
        self.showLoading = Observable.init(value: false)
        self.showError = Observable.init(value: "")
        self.contentList = Observable.init(value: content.map{ CellViewModel.init(userContent: $0) })
        self.service = service
        self.navTitle = ""
    }
    
    public func fetchContent() {
        
        guard AppManager.sharedInstance.isInternetAvailable() else {
            self.showError.value = "Network not available"
            return
        }
        
        self.showLoading.value = true
        
        self.service.fetchContent(success: { (contentList, title) in
            self.navTitle = title
            self.contentList.value = contentList.map{ CellViewModel.init(userContent: $0) }
            self.showLoading.value = false
        }) {
            self.showError.value = $0.rawValue
            self.showLoading.value = false
        }
    }
    
}

