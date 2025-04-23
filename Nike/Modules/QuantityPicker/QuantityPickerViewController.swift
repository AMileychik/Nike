//
//  QtySelectionViewController.swift
//  Nike
//
//  Created by Александр Милейчик on 2/1/25.
//

import UIKit

protocol QuantitySelectionDelegate: AnyObject {
    func didSelectQuantity(_ quantity: Double)
}

final class QuantityPickerViewController: UIViewController {
    
    weak var delegate: QuantitySelectionDelegate?
    
    private let quantityPickerView = UIPickerView()
    private let quantityOptions = Array(1...10)
    
    private let selectQuantityButton = CustomButton(
        title: Text.QuantityPickerViewController.done,
        backgroundColor: .black, 
        titleColor: .white,
        cornerRadius: 26)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupButtonAction()
        
        quantityPickerView.dataSource = self
        quantityPickerView.delegate = self
    }
    
    private func setupButtonAction() {
        selectQuantityButton.onButtonTapped = { [weak self] in
        self?.completeSelection()
        }
    }
}

//MARK: - Action Handler
extension QuantityPickerViewController {
    
    private func completeSelection() {
        let selectedRow = quantityPickerView.selectedRow(inComponent: 0)
        let selectedQuantity = quantityOptions[selectedRow]
        delegate?.didSelectQuantity(Double(selectedQuantity))
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension QuantityPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        quantityOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(quantityOptions[row])"
    }
}

//MARK: - Layout
extension QuantityPickerViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        [quantityPickerView, selectQuantityButton].forEach { view.addSubview($0) }
    }
   
    private func setupConstraints() {
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
