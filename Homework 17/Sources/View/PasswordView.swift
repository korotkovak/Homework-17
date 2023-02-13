//
//  View.swift
//  Homework 17
//
//  Created by Kristina Korotkova on 13/02/23.
//

import UIKit

class PasswordView: UIView {

    // MARK: - UI Elements

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your password"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.placeholder = "Your password"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 6
        return textField
    }()

    lazy var passwordEntryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        button.setTitle("Password generation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        return button
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 15
        stack.addArrangedSubview(passwordEntryButton)
        stack.addArrangedSubview(activityIndicator)
        return stack
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        activityIndicator.startAnimating()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(passwordTF)
        addSubview(stack)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(200)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }

        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
        }

        passwordEntryButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }

        stack.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }
}
