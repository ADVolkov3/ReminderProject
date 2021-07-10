//
//  ChengePasswordViewController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 08.07.2021.
//

import UIKit

class ChengePasswordViewController: UIViewController {
    
    var users: [Person] = []
    
    var user: [Person] = []

    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    @IBOutlet weak var firstNewPassword: UITextField!
    
    @IBOutlet weak var secondNewPassword: UITextField!
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ViewController()
        users = view.getAllUsers()
        user = view.getPersonWhichLogIn()
    }
    
    @IBAction func didClickSaveButton(_ sender: Any) {
        for i in 0 ..< users.count {
            if users[i].login == user[0].login {
            if users[i].password == oldPasswordTextField.text{
                if firstNewPassword.text == secondNewPassword.text {
                    user.removeAll()
                    user.append(Person(login: users[i].login, name: users[i].name, surName: users[i].surName, email: users[i].email, password: firstNewPassword.text!))
                    users.append(Person(login: users[i].login, name: users[i].name, surName: users[i].surName, email: users[i].email, password: firstNewPassword.text!))
                    users.remove(at: i)
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "personsArray")
                    notificationLabel.isHidden = false
                    notificationLabel.text = "Ваш пароль успешно изменен"
                    let view = ViewController()
                    view.setAllUsers(array: users)
                    let view2 = DataOfAccauntViewController()
                    view2.setUserWhichSignIn(logIn: user)
                    view.setUserWhichLogIn(user: user)
                    print(user)
                    return
                }else {
                    notificationLabel.text = "Пароли не совпадают"
                    notificationLabel.isHidden = false
                }
            }else {
                notificationLabel.text = "Неверный старый пароль"
                notificationLabel.isHidden = false
             }
         }
       }
     }
    
}
