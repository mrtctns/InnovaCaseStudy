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
        button.setTitleColor( .white, for: .normal)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setConstraints()
    }
    func setupUI(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        view.addSubviews(incomeExpenseButton, transactionNameTextField, cashTextField)
        
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
    }
    @objc
    func incomeExpenseClicked(){
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


}
