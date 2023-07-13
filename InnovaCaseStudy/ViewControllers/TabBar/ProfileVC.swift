//
//  ProfileVC.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import FirebaseAuth
import UIKit

class ProfileVC: UIViewController {
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: \(Global.shared.currentUser!.name ?? "")"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-Mail: \(Global.shared.currentUser!.email ?? "")"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private lazy var userIdLabel: UILabel = {
        let label = UILabel()
        label.text = "ID: \(Global.shared.currentUser!.userid ?? "")"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.addTarget(self, action: #selector(logOutClicked), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    func setupUI() {
        view.backgroundColor = .black
        view.addSubviews(profileImage,nameLabel, emailLabel, userIdLabel, logOutButton)
    }

    func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(userIdLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }

    @objc
    func logOutClicked() {
        do {
            try Auth.auth().signOut()
            navigationController?.navigationController?.pushViewController(LoginVC())
        } catch let signOutError as NSError {
            print("error: \(signOutError.localizedDescription)")
        }
    }
}
