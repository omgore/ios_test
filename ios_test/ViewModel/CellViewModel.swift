//
//  CellViewModel.swift
//  ios_test
//
//  Created by Om Gore on 16/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class CellViewModel {

    var userContent: UserContent
    static var placeholder: UIImage?
    var image: Observable<UIImage?>

    init(userContent: UserContent) {
        self.userContent = userContent

        if CellViewModel.placeholder == nil {
            CellViewModel.placeholder = UIImage.init(named: "placeholder4")
        }

        self.image = Observable.init(value: nil)
        self.bindCell()
    }

    var cell: UserContentListTableViewCell? {
        didSet {
            self.cell?.lblTitle.text = self.userContent.title ?? Constants.noTitle
            self.cell?.lblDescription.text = self.userContent.description ?? Constants.noSubtitle

            if let image = self.image.value {
                self.cell?.imgUserContent.image = image
            } else {
                self.cell?.imgUserContent.image = CellViewModel.placeholder
                if let imageURL = userContent.imageHref {
                    Alamofire.request(imageURL, method: .get).responseImage { response in
                        guard let image = response.result.value else {

                            return
                        }
                        self.image.value = image
                    }
                }
            }
        }
    }

    private func bindCell() {

        self.image.bindAndFire {
            self.cell?.imgUserContent.image = $0
        }
    }
}
