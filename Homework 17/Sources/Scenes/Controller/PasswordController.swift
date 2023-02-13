//
//  ViewController.swift
//  Homework 17
//
//  Created by Kristina Korotkova on 13/02/23.
//

import UIKit

class PasswordController: UIViewController {

    // MARK: - Property

    private var isStartPasswordGeneration = true

    private lazy var passwordView: PasswordView = {
        PasswordView()
    }()

    // MARK: - Leficycle

    override func loadView() {
        view = passwordView
        passwordView.frame = view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupAction() {
        passwordView.passwordEntryButton.addTarget(self, action: #selector(passwordGenerationButton), for: .touchUpInside)
        passwordView.stopButton.addTarget(self, action: #selector(stopGenerationButton), for: .touchUpInside)
    }

    // MARK: - Action

    @objc private func passwordGenerationButton() {

        isStartPasswordGeneration = true

        let password = passwordView.passwordTF.text ?? ""

        if password != "" {
            passwordView.startPasswordGeneration()

            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                self.bruteForce(passwordToUnlock: password)
            }
        }
    }

    @objc private func stopGenerationButton() {
        isStartPasswordGeneration = false
    }

    // MARK: - Generation Method

    private func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            if isStartPasswordGeneration {
                password = generateBruteForce(password, fromArray: allowedCharacters)

                DispatchQueue.main.async {
                    self.passwordView.titleLabel.text = password
                }

                print(password)

            } else {
                password = ""

                DispatchQueue.main.async {
                    let password = self.passwordView.passwordTF.text ?? ""
                    self.passwordView.titleLabel.text = "Password - \(password) not hacked"
                }

                break
            }

            DispatchQueue.main.async {
                self.passwordView.titleLabel.text = password
            }
        }
        passwordView.stopPasswordGeneration()
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
