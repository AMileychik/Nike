//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/8/25.
//

import UIKit
import DesignSystem
import AppCore

public protocol QuantitySelectionDelegate: AnyObject {
    func didSelectQuantity(_ quantity: Double)
}

public final class QuantityPickerViewController: UIViewController {

    public weak var delegate: QuantitySelectionDelegate?

    public let quantityPickerView = UIPickerView()
    public let quantityOptions = Array(1...10)

    public let selectQuantityButton = CustomButton(
        title: Text.QuantityPickerViewController.done,
        backgroundColor: .black,
        titleColor: .white,
        cornerRadius: 26)

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupButtonAction()

        quantityPickerView.dataSource = self
        quantityPickerView.delegate = self
    }

    public func setupButtonAction() {
        selectQuantityButton.onButtonTapped = { [weak self] in
        self?.completeSelection()
        }
    }
}

//MARK: - Action Handler
extension QuantityPickerViewController {

    public func completeSelection() {
        let selectedRow = quantityPickerView.selectedRow(inComponent: 0)
        let selectedQuantity = quantityOptions[selectedRow]
        delegate?.didSelectQuantity(Double(selectedQuantity))
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension QuantityPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    public func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        quantityOptions.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(quantityOptions[row])"
    }
}

//MARK: - Layout
extension QuantityPickerViewController {

    public func setupUI() {
        view.backgroundColor = .white
        [quantityPickerView, selectQuantityButton].forEach { view.addSubview($0) }
    }

    public func setupConstraints() {
        [quantityPickerView, selectQuantityButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            quantityPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quantityPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quantityPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            quantityPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),

            selectQuantityButton.topAnchor.constraint(equalTo: quantityPickerView.bottomAnchor, constant: 28),
            selectQuantityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            selectQuantityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            selectQuantityButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

