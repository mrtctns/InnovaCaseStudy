//
//  TransactionsTableCell.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit

class TransactionsTableCell: UITableViewCell {
    static let identifier = "TransactionsTableCell"
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    var item: Transactions = .init(type: .income, name: "", date: "", price: Price(value: 0, currency: "")) {
        didSet {
            nameLabel.text = item.name
            dateLabel.text = item.date
            priceLabel.text = item.price.calculatePrice()
            if item.type == .income {
                nameLabel.textColor = .systemGreen
                priceLabel.textColor = .systemGreen
            } else {
                nameLabel.textColor = .systemRed
                priceLabel.textColor = .systemRed
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: TransactionsTableCell.identifier)
        setupUI()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubviews(nameLabel, dateLabel, priceLabel)
    }

    func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(20)
        }
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        }
    }
}
