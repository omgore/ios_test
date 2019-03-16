//
//  UserContentListTableViewCell.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

class UserContentListTableViewCell: UITableViewCell {
    let imgUserContent:UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(named: "placeholder4")
        return imgVw
    }()
    
    let lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = UIColor.red
        lbl.numberOfLines = 0
        lbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return lbl
    }()
    
    let lblDescription:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.blue
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpCell()
    }
    
    // MARK: - Set up cell
    
    private func setUpCell(){
        contentView.addSubview(imgUserContent)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDescription)
        
        setConstraints()
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints(){
        imgUserContent.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
            make.top.equalToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.bottom.lessThanOrEqualToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
        }
        
        lblTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(imgUserContent.snp.trailing).offset(CONSTANT_MARGIN_IN_CELL)
            make.top.equalToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
            make.trailing.equalToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
        }
        
        lblDescription.snp.makeConstraints { (make) in
            make.leading.equalTo(imgUserContent.snp.trailing).offset(CONSTANT_MARGIN_IN_CELL)
            make.top.equalTo(lblTitle.snp.bottom)
            make.trailing.equalToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
            make.bottom.equalToSuperview().inset(CONSTANT_MARGIN_IN_CELL)
        }
        
    }

}
