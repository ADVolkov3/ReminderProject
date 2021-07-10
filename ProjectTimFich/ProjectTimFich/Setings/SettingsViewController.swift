//
//  SettingsViewController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 05.07.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var user: [Person] = []
    
    var users: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()    
    }
    
    //MARK: - Labels
    
    @IBOutlet weak var attantionLabel: UILabel!
    
    //MARK: - Buttons no action
    
    @IBOutlet weak var dataButton: UIButton!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var outFromAccauntButton: UIButton!
    
    @IBOutlet weak var deleteAccauntButton: UIButton!
    
    @IBAction func chengePasswordButton(_ sender: Any) {
    }
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var deleteYesButton: UIButton!
    
    //MARK: - Views
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    //MARK: - Buttons with action
    
    @IBAction func didClickDeleteAccauntButton(_ sender: Any) { // кнопка да для удаления аккаунта
        let view = ViewController()
        user = view.getPersonWhichLogIn()
        users = view.getAllUsers()
        print(user)
        for i in 0..<users.count {
            if users[i].login == user[0].login {
                users.remove(at: i)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "personsArray")
            }
            view.setAllUsers(array: users)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickYesButton(_ sender: Any){
        dismiss(animated: true, completion: nil)
        let view = ViewController()
        view.clearArray()
    }
    
    @IBAction func didClickNoButton(_ sender: Any) {
        mainView.backgroundColor = .white
        attantionLabel.isHidden = true
        yesButton.isHidden = true
        noButton.isHidden = true
        backgroundView.isHidden = true
    }
    
    @IBAction func exitFromAccauntButton(_ sender: Any) {
        mainView.backgroundColor = UIColor.gray
        backgroundView.layer.cornerRadius = 30
        attantionLabel.text = "Вы действительно хотите выйти из учетной записи?"
        backgroundView.isHidden = false
        attantionLabel.isHidden = false
        yesButton.isHidden = false
        noButton.isHidden = false
        
    }
    
    @IBAction func deleteAccauntButton(_ sender: Any) {
        mainView.backgroundColor = UIColor.gray
        backgroundView.layer.cornerRadius = 30
        attantionLabel.text = "Вы действительно хотите удалить учетную запись?"
        backgroundView.isHidden = false
        attantionLabel.isHidden = false
        deleteYesButton.isHidden = false
        noButton.isHidden = false
    }
}
