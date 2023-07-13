//
//  ExchangeVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit

class ExchangeVC: UIViewController {
    var currencyArr: [Currency] = []
    private lazy var walletTitle: UILabel = {
        let label = UILabel()
        label.text = "Cash: \(Global.shared.currentUser!.wallet!.calculatePrice())"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()

    let textPicker = CustomTextPicker()
    private lazy var cashTextField: UITextField = {
        let textField = UITextField()

        textPicker.completion = { text in
            textField.text = text
        }
        textField.inputView = textPicker
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.placeholder = "Select Currency"
        return textField
    }()

    private lazy var convertedTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private lazy var convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.addTarget(self, action: #selector(convertClicked), for: .touchUpInside)
        return button
    }()

    private lazy var currenciesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.backgroundColor = .systemGray6
        tableView.register(CurrenciesTableCell.self, forCellReuseIdentifier: CurrenciesTableCell.identifier)
        return tableView

    }()

    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationController?.setNavigationBarHidden(true, animated: false)
        getCurrencies()
        setupUI()
        setConstraints()
        updateWallet()
    }

    func setupUI() {
        view.backgroundColor = .black
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubviews(walletTitle, cashTextField, convertButton, convertedTitle, currenciesTableView, activityIndicator)
    }

    func setConstraints() {
        walletTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
        }
        cashTextField.snp.makeConstraints { make in
            make.top.equalTo(walletTitle.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(64)
            make.right.equalToSuperview().offset(-64)
            make.height.equalTo(64)
        }
        convertButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cashTextField.snp.bottom).offset(24)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        convertedTitle.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        currenciesTableView.snp.makeConstraints { make in
            make.top.equalTo(convertedTitle.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func updateWallet() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("UpdateWallet"), object: nil, queue: nil) { [self] _ in
            walletTitle.text = "Cash: \(Global.shared.currentUser!.wallet!.calculatePrice())"
        }
    }

    @objc
    func convertClicked() {
        startActivityIndicator()
        NetworkManager.shared.exchangeCurrency(from: "TRY", to: cashTextField.text!, amount: 340) { [self] result in
            switch result {
            case .success(let convertedAmount):
                self.convertedTitle.text = "Converted: \(convertedAmount)"
                stopActivityIndicator()
            case .failure(let error):
                print("Hata oluştu: \(error)")
                stopActivityIndicator()
            }
        }
    }

    func getCurrencies() {
        NetworkManager.shared.fetchCurrencyData { [self] result in
            switch result {
            case .success(let currency):
                currencyArr = currency
                textPicker.pickerData = []
                currencyArr.forEach { item in
                    textPicker.pickerData.append(item.currency)
                }
                currenciesTableView.reloadData()

            case .failure(let error):
                print("Hata: \(error)")
            }
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

extension ExchangeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currenciesTableView.dequeueReusableCell(withIdentifier: CurrenciesTableCell.identifier, for: indexPath) as! CurrenciesTableCell
        cell.item = currencyArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cashTextField.text = currencyArr[indexPath.row].currency
        currenciesTableView.reloadData()
    }
}
