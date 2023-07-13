//
//  CurrenciesTableCell.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 13.07.2023.
//

import UIKit

class CurrenciesTableCell: UITableViewCell {
    static let identifier = "CurrenciesTableCell"
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    var item = Currency(currency: "", country: "") {
        didSet{
            currencyLabel.text = item.currency
            countryLabel.text = item.country
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: CurrenciesTableCell.identifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        contentView.backgroundColor = .systemGray6
        contentView.addSubviews(currencyLabel, countryLabel)
    }
    func setConstraints(){
        currencyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.centerY.equalToSuperview()
        }
        countryLabel.snp.makeConstraints { make in
            make.left.equalTo(currencyLabel.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
}
