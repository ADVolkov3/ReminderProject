//
//  CheckInController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 04.07.2021.
//

import UIKit

struct Person: Codable {
    var login: String
    var name: String
    var surName: String
    var email: String
    var password: String
}

class CheckInViewController: UIViewController {
    
//    var dataOfPasswords : [String] = [] // массив паролей юзеров
    
    var dataSourceAccaunts: [Person] = [] // засунуть данные из userDefaults
    
    func getDataSource() -> [Person] {
        return dataSourceAccaunts
    }
    
    // MARK: - TextFields
    
    @IBOutlet weak var loginOfAccaunt: UITextField!
    @IBOutlet weak var surnameAccaunt: UITextField!
    @IBOutlet weak var nameAccaunt: UITextField!
    @IBOutlet weak var emailAccaunt: UITextField!
    @IBOutlet weak var passwordAccaunt: UITextField!
    @IBOutlet weak var reapetPasswordAccunt: UITextField!
    
    // MARK: - Buttons no action
    
    @IBOutlet weak var showButton: UIButton!
    
    // MARK: - Labels
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        if let data = UserDefaults.standard.object(forKey: "personsArray") as? Data {
            dataSourceAccaunts = try! PropertyListDecoder().decode(Array<Person>.self, from: data)
        }
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CheckInViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Buttons with action
    
    @IBAction func didClickSaveProfileButton(_ sender: Any) {
        var flag: Bool = true
        // Проверка на то не было ли такого же логина до этого
        for person in dataSourceAccaunts {
            if loginOfAccaunt.text == person.login{
                notificationLabel.isHidden = false
                notificationLabel.text = "Такой логин уже существует в базе придумайте новый"
                flag = false
            }
        }
        if flag {
            newAccaunt()
        }
    }
    
    func newAccaunt() -> Void {
        if let emailAccountText = emailAccaunt.text?.lowercased(),
           emailAccountText.contains("@"), passwordAccaunt.text == reapetPasswordAccunt.text {
            dataSourceAccaunts.append(Person(login: loginOfAccaunt.text!, name: nameAccaunt.text!, surName: surnameAccaunt.text!, email: emailAccaunt.text!, password: passwordAccaunt.text!))
            UserDefaults.standard.set(try? PropertyListEncoder().encode(dataSourceAccaunts), forKey: "personsArray")
//            for person in dataSourceAccaunts {
//                dataOfPasswords.append(person.password)
//            }
//            UserDefaults.standard.set(try? PropertyListEncoder().encode(dataOfPasswords), forKey: "passwordArray")
            
            notificationLabel.text = "Ваш аккаунт успешно сохранен"
            notificationLabel.isHidden = false
        } else {
            notificationLabel.text = "Что-то пошло не так, проверте написанное"
            notificationLabel.isHidden = false
        }
    }
    
    // MARK: - скрытие и появление пароля для двух полей
    
    var countOfTaping: Int = 0
    @IBAction func didClickPasswordShowButton(_ sender: Any) {
        if countOfTaping % 2 == 0 /*&& passwordAccaunt.text != "" */ {
            
            passwordAccaunt.isSecureTextEntry = false
            countOfTaping += 1
        } else /*if passwordAccaunt.text != nil */{
            passwordAccaunt.isSecureTextEntry = true
            countOfTaping += 1
        }
    }
    
    var ReapetCountOfTaping: Int = 0
    @IBAction func didClickReapeatPasswordShowButton(_ sender: Any) {
        if ReapetCountOfTaping % 2 == 0 /* && passwordAccaunt.text != "" */{
            reapetPasswordAccunt.isSecureTextEntry = false
            
            ReapetCountOfTaping += 1
        } else /* if passwordAccaunt.text != nil */{
            reapetPasswordAccunt.isSecureTextEntry = true
            ReapetCountOfTaping += 1
        }
    }
}
