//
//  ExchangeVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit

class ExchangeVC: UIViewController {
    private lazy var walletTitle: UILabel = {
        let label = UILabel()
        label.text = "Cash: \(Global.shared.currentUser!.wallet!.calculatePrice())"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    private lazy var cashTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.placeholder = "Select Currency"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setConstraints()
        updateWallet()
    }
    func setupUI(){
        view.backgroundColor = .black
        view.addSubviews(walletTitle)
    }
    func setConstraints(){
        walletTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
        }
    }
    func updateWallet(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("UpdateWallet"), object: nil, queue: nil) { [self] notification in
            walletTitle.text = "Cash: \(Global.shared.currentUser!.wallet!.calculatePrice())"
            
        }
    }
    


}
