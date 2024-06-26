//
//  LoginVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import FirebaseAuth
import UIKit

class LoginVC: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.keyboardType = .emailAddress
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

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        return button
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        setupUI()
        setConstraints()
    }

    func setupUI() {
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .black
        view.addSubviews(titleLabel, emailTextField, passwordTextField, loginButton, signUpButton, activityIndicator)
    }

    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
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
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }

    @objc
    func loginClicked() {
        startActivityIndicator()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { _, err in
            if err != nil {
                print(err)
                self.stopActivityIndicator()
            } else {
                FirebaseManager.shared.fetchCurrentUserDetails { [self] user in
                    Global.shared.currentUser = user
                    stopActivityIndicator()
                    navigationController?.pushViewController(TabBarController())
                }
            }
        }
    }

    @objc
    func signUpClicked() {
        navigationController?.pushViewController(SignUpVC())
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
