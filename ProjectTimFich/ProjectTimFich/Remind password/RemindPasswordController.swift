//
//  RemindPasswordControllerViewController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 07.07.2021.
//

import UIKit

class RemindPasswordController: UIViewController {
    
    var arrayOfUsers: [Person] = []
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var liginOrPasswordLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var enteringTextField: UITextField!
    
    @IBOutlet weak var backgroundViewlogin: UIButton!
    
    @IBOutlet weak var passwordSerchingButton: UIButton!
    
    @IBOutlet weak var loginSerchingButton: UIButton!
    
    @IBOutlet weak var backgroungViewPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundViewlogin.layer.cornerRadius = 20
        backgroungViewPassword.layer.cornerRadius = 20
        self.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: self, action: #selector(RemindPasswordController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickpasswordSerchingButton(_ sender: Any) {
        
        if let data = UserDefaults.standard.object(forKey: "personsArray") as? Data {
            arrayOfUsers = try! PropertyListDecoder().decode(Array<Person>.self, from: data)
        }
        print(arrayOfUsers)
        
        for person in arrayOfUsers {
            if person.login == enteringTextField.text {
                liginOrPasswordLabel.isHidden = false
                liginOrPasswordLabel.text = "Ваш пароль: \(person.password)"
                return
            } else {
                liginOrPasswordLabel.isHidden = false
                liginOrPasswordLabel.text = "Такой логин не найден"
            }
        }
    }
    
    @IBAction func didClickLoginSerchingButton(_ sender: Any) {
        if let data = UserDefaults.standard.object(forKey: "personsArray") as? Data {
            arrayOfUsers = try! PropertyListDecoder().decode(Array<Person>.self, from: data)
        }
        print(arrayOfUsers)
        for person in arrayOfUsers {
            if person.email == enteringTextField.text{
                liginOrPasswordLabel.isHidden = false
                liginOrPasswordLabel.text = "Ваш логин: \(person.login)"
                return
            } else{
                liginOrPasswordLabel.isHidden = false
                liginOrPasswordLabel.text = "Такой email не найден"
            }
        }
    }
    
    @IBAction func didClickLoginButton(_ sender: Any) {
        passwordSerchingButton.isHidden = true
        notificationLabel.text = "Введите почту от аккаунта"
        notificationLabel.isHidden = false
        enteringTextField.isHidden = false
        lineView.isHidden = false
        loginSerchingButton.isHidden = false
    }
    
    @IBAction func didClickPasswordButton(_ sender: Any) {
        loginSerchingButton.isHidden = true
        notificationLabel.text = "Введите логин от аккаунта"
        notificationLabel.isHidden = false
        enteringTextField.isHidden = false
        lineView.isHidden = false
        passwordSerchingButton.isHidden = false
    }
}
