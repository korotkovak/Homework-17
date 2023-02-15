//
//  View.swift
//  Homework 17
//
//  Created by Kristina Korotkova on 13/02/23.
//

import UIKit

final class PasswordView: UIView {

    // MARK: - UI Elements

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Взломать пароль?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    lazy var generationPasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.placeholder = "Нашите Ваш пароль"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 6
        textField.isSecureTextEntry = true
        return textField
    }()

    lazy var passwordEntryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.setTitle("Взломать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    lazy var changeViewBackgroundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 6
        button.setTitle("Поменять цвет", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 6
        button.setTitle("Остановить взлом", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        return indicator
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.addArrangedSubview(passwordEntryButton)
        stack.addArrangedSubview(activityIndicator)
        return stack
    }()

    private lazy var stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 14
        stack.addArrangedSubview(changeViewBackgroundButton)
        stack.addArrangedSubview(stopButton)
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
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(generationPasswordLabel)
        addSubview(passwordTF)
        addSubview(stack)
        addSubview(stackButton)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }

        generationPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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

        changeViewBackgroundButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }

        stopButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }

        stackButton.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(14)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }
}
