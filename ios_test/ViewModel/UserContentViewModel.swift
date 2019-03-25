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

    var showLoading: Observable<Bool>
    var showError: Observable<String>
    var contentList: Observable<[CellViewModel]>
    var service: ContentAPI
    var navTitle: String

    init(content: [UserContent], service: ContentAPI, title: String) {
        self.showLoading = Observable.init(value: false)
        self.showError = Observable.init(value: "")
        self.contentList = Observable.init(value: content.map { CellViewModel.init(userContent: $0) })
        self.service = service
        self.navTitle = ""
    }

    public func fetchContent() {

        guard AppManager.sharedInstance.isInternetAvailable() else {
            self.showError.value = Constants.networkNotAvailable
            return
        }

        self.showLoading.value = true

        self.service.fetchContent { (userWrapper, error) in
            guard let userWrapper = userWrapper else {
                self.showError.value = error!.localizedDescription
                self.showLoading.value = false
                return
            }
            self.navTitle = userWrapper.title!
            if userWrapper.rows!.isEmpty {
                self.showError.value = Constants.userListEmpty
                self.showLoading.value = false
            } else {
                self.contentList.value = userWrapper.rows!.map { CellViewModel.init(userContent: $0) }
                self.showLoading.value = false
            }

        }
    }

}
