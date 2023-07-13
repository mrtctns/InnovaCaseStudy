//
//  HistoryVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit

class BudgetVC: UIViewController {
    var isExpense = false
    private lazy var incomeExpenseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Income", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(incomeExpenseClicked), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var transactionNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.placeholder = "Transaction Name"
        return textField
    }()

    private lazy var cashTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.placeholder = "Cash"
        return textField
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Transaction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        return button
    }()

    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        setupUI()
        setConstraints()
    }

    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubviews(incomeExpenseButton, transactionNameTextField, cashTextField, addButton, activityIndicator)
    }

    func setConstraints() {
        incomeExpenseButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        transactionNameTextField.snp.makeConstraints { make in
            make.top.equalTo(incomeExpenseButton.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        cashTextField.snp.makeConstraints { make in
            make.top.equalTo(transactionNameTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(cashTextField.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.height.equalTo(50)
        }
    }

    @objc
    func incomeExpenseClicked() {
        if isExpense {
            incomeExpenseButton.setTitle("Income", for: .normal)
            incomeExpenseButton.backgroundColor = .systemGreen
            isExpense.toggle()
        } else {
            incomeExpenseButton.setTitle("Expense", for: .normal)
            incomeExpenseButton.backgroundColor = .systemRed
            isExpense.toggle()
        }
    }

    @objc
    func addClicked() {
        if transactionNameTextField.text != "", cashTextField.text != "" {
            let type = isExpense ? Transactions.TransactionType.expense : Transactions.TransactionType.income
            let transaction = Transactions(type: type, name: transactionNameTextField.text, date: Date().toString(), price: Price(value: Double(cashTextField.text!)!, currency: .TRY))
            startActivityIndicator()

            FirebaseManager.shared.addTransactions(object: transaction) {[self] _ in
                FirebaseManager.shared.updateWallet(isExpense: isExpense, cash: Double(cashTextField.text!)!, currencyType: .TRY) { [self] _ in
                    FirebaseManager.shared.fetchCurrentUserDetails { [self] user in
                        Global.shared.currentUser = user
                        NotificationCenter.default.post(name: NSNotification.Name("UpdateWallet"), object: nil)
                        stopActivityIndicator()
                        Global.shared.transactionsArr.append(transaction)
                        
                    }
                }
            }

        } else {
            print("error")
        }
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}
