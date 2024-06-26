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
        label.text = "My Wallet: \(Global.shared.currentUser!.wallet!.calculatePrice())"
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
        tableView.rowHeight = 50
        tableView.backgroundColor = .systemGray6
        tableView.register(TransactionsTableCell.self, forCellReuseIdentifier: TransactionsTableCell.identifier)
        return tableView

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
        setupUI()
        setConstraints()
        updateWallet()
    }

    override func viewWillAppear(_ animated: Bool) {
        transactionsTableView.reloadData()
    }

    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        view.addSubviews(walletTitle, recentTransactionsLabel, transactionsTableView)
    }

    func setConstraints() {
        walletTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        recentTransactionsLabel.snp.makeConstraints { make in
            make.top.equalTo(walletTitle.snp.bottom).offset(36)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        transactionsTableView.snp.makeConstraints { make in
            make.top.equalTo(recentTransactionsLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func updateWallet() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("UpdateWallet"), object: nil, queue: nil) { [self] _ in
            walletTitle.text = "My Wallet: \(Global.shared.currentUser!.wallet!.calculatePrice())"
        }
    }

    func fetchProduct() {
        do {
            let updatedTransactions = try NetworkManager.shared.readJSONData(fileName: "Action", objectType: [Transactions].self)
            updatedTransactions.forEach { Transaction in
                Global.shared.transactionsArr.append(Transaction)
            }

        } catch {
            print("Hata: \(error)")
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.shared.transactionsArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionsTableView.dequeueReusableCell(withIdentifier: TransactionsTableCell.identifier, for: indexPath) as! TransactionsTableCell
        cell.item = Global.shared.transactionsArr[indexPath.row]
        return cell
    }
}
