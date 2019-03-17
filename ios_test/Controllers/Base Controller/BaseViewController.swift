//
//  BaseViewController.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol BaseViewProtocol:class {
    @objc func clickOnRetry()
}

class BaseViewController: UIViewController {

    let lblNoInternetMsg:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.red
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnRetry:UIButton = {
        let btn = UIButton()
        btn.setTitle("Retry", for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(BaseViewProtocol.clickOnRetry), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        setNoInternetView()
    }
    
    // MARK: - Set Up No internet view
    
    private func setNoInternetView()
    {
        view.addSubview(lblNoInternetMsg)
        view.addSubview(btnRetry)
        
        lblNoInternetMsg.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalToSuperview().offset(Constants.CONSTANT_MARGIN_IN_CELL)
            make.trailing.equalToSuperview().inset(Constants.CONSTANT_MARGIN_IN_CELL)
        }
        
        btnRetry.snp.makeConstraints { (make) in
            make.top.equalTo(lblNoInternetMsg.snp.bottom).offset(Constants.CONSTANT_MARGIN_IN_CELL)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        lblNoInternetMsg.isHidden = true
        btnRetry.isHidden = true
    }
    
    // MARK: - Show No Internet View
    
    final func showInternetViewWithMsg(msg:String)
    {
        if msg.count > 0
        {
            navigationItem.rightBarButtonItem = nil
            lblNoInternetMsg.isHidden = false
            btnRetry.isHidden = false
            lblNoInternetMsg.text = msg
        }
        else
        {
            lblNoInternetMsg.isHidden = true
            btnRetry.isHidden = true
            lblNoInternetMsg.text = ""
        }
    }
    
}
