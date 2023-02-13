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
    }

    // MARK: - Setup

    private func setupView() {
        view = PasswordView()
        view.backgroundColor = .white
    }
}
