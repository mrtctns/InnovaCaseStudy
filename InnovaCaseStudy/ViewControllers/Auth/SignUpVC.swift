//
//  SignUpVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 3
        textField.placeholder = "Name"
        return textField
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 3
        textField.placeholder = "E-Mail"
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 3
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()

   

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    func setupUI() {
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .black
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubviews(titleLabel, nameTextField, emailTextField, passwordTextField, signUpButton, activityIndicator)
    }

    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }

    @objc
    func signUpClicked() {
        if nameTextField.text != "" && emailTextField.text! != "", passwordTextField.text != "" {
            startActivityIndicator()
            FirebaseManager.shared.addUser(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { [self] result in
                
                stopActivityIndicator()
                navigationController?.pushViewController(TabBarController())
                
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
