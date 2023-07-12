//
//  HistoryVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit

class BudgetVC: UIViewController {
    private lazy var addIncomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Income", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor( .white, for: .normal)
        //button.addTarget(self, action: #selector(incomeButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    private lazy var addExpenseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Expense", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor( .white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }


}
