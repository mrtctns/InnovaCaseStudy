//
//  HomeVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import SnapKit
import UIKit

class HomeVC: UIViewController {
    private lazy var walletTitle: UILabel = {
        let label = UILabel()
        label.text = "My Wallet:"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()

    private lazy var recentTransactionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        return label
    }()

    private lazy var transactionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.register(TransactionsTableCell.self, forCellReuseIdentifier: TransactionsTableCell.identifier)

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    func setupUI() {
        view.addSubviews(walletTitle, recentTransactionsLabel, transactionsTableView)
    }

    func setConstraints() {
        walletTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(20)
        }
        recentTransactionsLabel.snp.makeConstraints { make in
            make.top.equalTo(walletTitle.snp.bottom).offset(36)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        transactionsTableView.snp.makeConstraints { make in
            make.top.equalTo(recentTransactionsLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
