//
//  ViewController.swift
//  Homework 17
//
//  Created by Kristina Korotkova on 13/02/23.
//

import UIKit

class ViewController: UIViewController {

    private var passwordView: PasswordView? {
        guard isViewLoaded else { return nil }
        return view as? PasswordView
    }

    // MARK: - Leficycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }

    // MARK: - Setup

    private func setupView() {
        view = PasswordView()
        view.backgroundColor = .white
    }

    private func setupAction() {
        passwordView?.passwordEntryButton.addTarget(self, action: #selector(passwordGenerationButton), for: .touchUpInside)
    }

    // MARK: - Action

    @objc func passwordGenerationButton() {
        let password = randomPassword(passwordLength: 4)
        passwordView?.passwordTF.text = password
        passwordView?.activityIndicator.isHidden = false
        passwordView?.activityIndicator.startAnimating()

        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.bruteForce(passwordToUnlock: password)
        }
    }

    func randomPassword(passwordLength: Int) -> String {
        let passwordLetters = String().printable
        var passwordWord = ""
        for _ in 0 ..< passwordLength {
            guard let value = passwordLetters.randomElement() else { return "" }
            passwordWord.append(value)
        }
        return passwordWord
    }

    // MARK: - Generation Method

    func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            DispatchQueue.main.async {
                self.passwordView?.titleLabel.text = password
            }
//            print(password)
        }

        DispatchQueue.main.async {
            self.passwordView?.titleLabel.text = password
            self.passwordView?.activityIndicator.stopAnimating()
            self.passwordView?.activityIndicator.isHidden = true
        }
    }

    // MARK: - Generation Method

        func indexOf(character: Character, _ array: [String]) -> Int {
            return array.firstIndex(of: String(character)) ?? 0
        }

        func characterAt(index: Int, _ array: [String]) -> Character {
            return index < array.count ? Character(array[index]) : Character("")

        }

        func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
            var str: String = string

            if str.count <= 0 {
                str.append(characterAt(index: 0, array))
            } else {
                guard let strLast = str.last else { return "" }

                str.replace(at: str.count - 1,
                            with: characterAt(index: (indexOf(character: strLast, array) + 1) % array.count, array))

                if indexOf(character: strLast, array) == 0 {
                    str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(strLast)
                }
            }

            return str
        }

//    func indexOf(character: Character, _ array: [String]) -> Int {
//        return array.firstIndex(of: String(character))!
//    }
//
//    func characterAt(index: Int, _ array: [String]) -> Character {
//        return index < array.count ? Character(array[index])
//        : Character("")
//    }
//
//    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
//        var str: String = string
//
//        if str.count <= 0 {
//            str.append(characterAt(index: 0, array))
//        }
//        else {
//            str.replace(at: str.count - 1,
//                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
//
//            if indexOf(character: str.last!, array) == 0 {
//                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
//            }
//        }
//
//        return str
//    }



}
