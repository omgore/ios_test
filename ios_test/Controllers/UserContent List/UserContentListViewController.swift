//
//  UserContentListViewController.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

class UserContentListViewController: BaseViewController {

    var tblVw:UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var arrUserContentViewModel = [UserContentViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadInitialSettings()
    }
    
    // MARK: - Load Initial Settings
    
    private func loadInitialSettings()
    {
        loadTableView()        
        addRefreshControl()
        
        tblVw.isHidden = true
        callAPI()
        
    }
    
    // MARK: - Add Refresh control to table view
    
    private func addRefreshControl() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tblVw.refreshControl = refreshControl
        } else {
            tblVw.addSubview(refreshControl)
        }
    }
    
    // MARK: - Refresh control method
    
    @objc func pullToRefresh(){
        refreshControl.endRefreshing()
        
        if isActivityIndicatorAnimating()
        {
            return
        }
        
        callAPI()
    }
    
    // MARK: - Load Table view
    
    private func loadTableView()
    {
        tblVw = UITableView(frame: view.bounds, style: .plain)
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.estimatedRowHeight = 100
        
        tblVw.register(UserContentListTableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        
        view.addSubview(tblVw)
        
        tblVw.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - API call from base view
    
    private func callAPI()
    {
        if !AppManager.sharedInstance.isInternetAvailable()
        {
            tblVw.isHidden = true
            showInternetViewWithMsg(show: true, msg: "It seems the internet connection has been lost.\n Please retry when your connection returns.")
            return
        }
        
        startActivityIndicator()
        
        APIManager.sharedInstance.callJSONAPI(success: { (userContentWrapper) in
            self.stopActivityIndicator()
            self.title = userContentWrapper.title
            
            self.arrUserContentViewModel = userContentWrapper.rows?.map({return UserContentViewModel(objUserContent: $0)}) ?? []
            
            if self.arrUserContentViewModel.count > 0
            {
                self.tblVw.isHidden = false
                self.showInternetViewWithMsg(show: false, msg: "")
                self.tblVw.reloadData()
            }
            else
            {
                self.showInternetViewWithMsg(show: true, msg: "No data available.")
            }
            
        }) { (error) in
            self.stopActivityIndicator()
            self.showInternetViewWithMsg(show: true, msg: error.localizedDescription)
        }
        
    }
    
}

// MARK: - TableView DataSource And Delegate

extension UserContentListViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrUserContentViewModel.count == 0
        {
            return 0
        }
        return arrUserContentViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UserContentListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as? UserContentListTableViewCell
        if cell == nil
        {
            cell = UserContentListTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: CELL_IDENTIFIER)
        }
        
        cell?.selectionStyle = .none
        
        if arrUserContentViewModel.count == 0
        {
            return cell!
        }
        
        cell?.objUserContentViewModel = arrUserContentViewModel[indexPath.row]
        
        return cell!
    }
}


// MARK: - Base view controller protocol

extension UserContentListViewController : BaseViewProtocol
{
    func clickOnRetry() {
        self.showInternetViewWithMsg(show: false, msg: "")
        callAPI()
    }
}
