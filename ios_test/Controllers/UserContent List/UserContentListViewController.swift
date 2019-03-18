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
    
    var viewModel: UserContentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialSettings()
    }
    
    // MARK: - Bind View Model
    
    private func bindViewModel() {
        viewModel?.showLoading.bindAndFire(listener: {
            if $0 {
                self.startActivityIndicator()
            } else {
                self.stopActivityIndicator()
            }
        })
        
        viewModel?.showError.bindAndFire(listener: {
            self.showInternetViewWithMsg(msg: $0)
        })
        
        viewModel?.contentList.bindAndFire(listener: {
            self.title = self.viewModel?.navTitle
            if $0.count > 0 {
                self.tblVw.isHidden = false
                self.tblVw.reloadData()
            } else {
                self.tblVw.isHidden = true
            }
        })
    }
    
    // MARK: - Load Initial Settings
    
    private func loadInitialSettings() {
        loadTableView()        
        addRefreshControl()
        viewModel?.fetchContent()
        
        bindViewModel()
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
    
    @objc func pullToRefresh() {
        refreshControl.endRefreshing()
        
        if isActivityIndicatorAnimating()
        {
            return
        }
        
        viewModel?.fetchContent()
    }
    
    // MARK: - Load Table view
    
    private func loadTableView() {
        tblVw = UITableView(frame: view.bounds, style: .plain)
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.estimatedRowHeight = 100
        
        tblVw.register(UserContentListTableViewCell.self, forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        
        view.addSubview(tblVw)
        
        tblVw.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - TableView DataSource And Delegate

extension UserContentListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.contentList.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER, for: indexPath) as? UserContentListTableViewCell else {
            fatalError("Not able to load cell from nib")
        }
        
        cell.selectionStyle = .none
        
        if let cellViewModel = viewModel?.contentList.value[indexPath.row] {
            cellViewModel.cell = cell
        }
       
        return cell
    }
}


// MARK: - Base view controller protocol

extension UserContentListViewController: BaseViewProtocol {
    func clickOnRetry() {
        self.showInternetViewWithMsg(msg: "")
        viewModel?.fetchContent()
    }
}
