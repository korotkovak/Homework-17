//
//  ViewController.swift
//  Homework 17
//
//  Created by Kristina Korotkova on 13/02/23.
//

import UIKit

final class PasswordController: UIViewController {

    // MARK: - Property

    private lazy var passwordView: PasswordView = {
        PasswordView()
    }()

    private var isStartPasswordGeneration = true

    var isBlack: Bool = false {
        didSet {
            if isBlack {
                view.backgroundColor = .black
                passwordView.titleLabel.textColor = .white
                passwordView.activityIndicator.color = .white
                passwordView.generationPasswordLabel.textColor = .white
            } else {
                view.backgroundColor = .white
                passwordView.titleLabel.textColor = .black
                passwordView.activityIndicator.color = .black
                passwordView.generationPasswordLabel.textColor = .black
            }
        }
    }

    // MARK: - Observers

    var observerLabel: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.passwordView.generationPasswordLabel.text = self.observerLabel
            }
        }
    }

    var observerTitleLabel: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.passwordView.titleLabel.text = self.observerTitleLabel
            }
        }
    }

    // MARK: - Leficycle

    override func loadView() {
        view = passwordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupKeyboard()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupKeyboard() {
        passwordView.passwordTF.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    private func setupAction() {
        passwordView.passwordEntryButton.addTarget(self, action: #selector(startPasswordGenerationButton), for: .touchUpInside)
        passwordView.stopButton.addTarget(self, action: #selector(stopPasswordGenerationButton), for: .touchUpInside)
        passwordView.changeViewBackgroundButton.addTarget(self, action: #selector(changeViewBackgroundColor), for: .touchUpInside)
    }

    // MARK: - Action

    @objc private func changeViewBackgroundColor() {
        isBlack.toggle()
    }

    @objc private func startPasswordGenerationButton() {
        guard let password = passwordView.passwordTF.text else { return }
        guard password != "" else { return }

        passwordView.activityIndicator.startAnimating()
        observerTitleLabel = "Идет взлом"

        let queue = DispatchQueue(label: "bruteForce", qos: .background)
        queue.async {
            self.bruteForce(passwordToUnlock: password)
            self.updateView()
        }
    }

    @objc private func stopPasswordGenerationButton() {
        isStartPasswordGeneration = false
        passwordView.activityIndicator.stopAnimating()

        guard let password = passwordView.passwordTF.text else { return }
        guard let titleLabel = passwordView.titleLabel.text else { return }

        guard titleLabel == "Взломать пароль?" || titleLabel == "Пароль взломан \(password)" else {
            observerTitleLabel = "Взлом остановлен"
            return
        }

        updateView()
    }

    private func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.passwordView.passwordTF.isSecureTextEntry = true
            self.observerTitleLabel = "Взломать пароль?"
            self.observerLabel = ""
        }
    }

    // MARK: - Generation Method

    private func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            if isStartPasswordGeneration {
                password = generateBruteForce(password, fromArray: allowedCharacters)
                observerLabel = password

                if password == passwordToUnlock {
                    observerTitleLabel = "Пароль взломан \(password)"
                    observerLabel = ""

                    DispatchQueue.main.async {
                        self.passwordView.activityIndicator.stopAnimating()
                        self.passwordView.passwordTF.isSecureTextEntry = false
                    }
                }
            } else {
                password = ""
                isStartPasswordGeneration = true
                break
            }
        }
    }
}

// MARK: - Extension

extension PasswordController {

    private func indexOf(character: Character, _ array: [String]) -> Int {
        guard let index = array.firstIndex(of: String(character)) else { return 0 }
        return index
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")

    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last ?? "a", array) + 1) % array.count, array))

            if indexOf(character: str.last ?? "a", array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last ?? "a")
            }
        }

        return str
    }
}

extension PasswordController: UITextFieldDelegate {

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
