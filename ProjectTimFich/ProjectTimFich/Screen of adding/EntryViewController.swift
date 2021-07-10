//
//  EntryViewController.swift
//  swiftProject
//
//  Created by Александр on 10.07.2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func saveTask() {
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {
            let targetDate = datePicker.date
            completion?(titleText, bodyText, targetDate)
        }
    }

}
