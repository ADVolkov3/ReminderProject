//
//  ViewController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 03.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    static var personWhichLogIn: [Person] = []
    
    static var arrayOfUsers: [Person] = []
    
    //    static var passwordArray: [String] = []
    
    func getAllUsers() -> [Person] {
        return ViewController.arrayOfUsers
    }
    
    func setAllUsers(array: [Person]) -> Void {
        ViewController.arrayOfUsers = array
    }
    
    func getPersonWhichLogIn() -> [Person] {
        return ViewController.personWhichLogIn
    }
    
    func setUserWhichLogIn(user: [Person]) {
        ViewController.personWhichLogIn = user
    }
    
    func clearArray(){
        ViewController.personWhichLogIn.removeAll()
    }
    
    // MARK: - TextFields
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lables
    
    @IBOutlet weak var attentionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Buttons
    
    @IBAction func checkInButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        //        if let data = UserDefaults.standard.object(forKey: "passwordArray") as? Data {
        //            ViewController.passwordArray = try! PropertyListDecoder().decode(Array<String>.self, from: data)
        //              }
        //        print(ViewController.passwordArray)
        
        if let data = UserDefaults.standard.object(forKey: "personsArray") as? Data {
            ViewController.arrayOfUsers = try! PropertyListDecoder().decode(Array<Person>.self, from: data)
        }
        print(ViewController.arrayOfUsers)
        if ViewController.arrayOfUsers.count == 0 {
            attentionLabel.isHidden = false
            attentionLabel.text = "В базе нет ни одного аккаунта, создайте его"
        }
        for person in ViewController.arrayOfUsers {
            ViewController.personWhichLogIn.removeAll()
            if person.login == loginTextField.text && person.password == passwordTextField.text {
                ViewController.personWhichLogIn.append(person)
                attentionLabel.isHidden = true
                print("Person which log in: ")
                print(ViewController.personWhichLogIn)
                attentionLabel.isHidden = true
                let storyboard = UIStoryboard(name: "GeneralScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "1234")
                self.present(vc, animated: true, completion: nil)
                return
            } else{
                attentionLabel.isHidden = false
                attentionLabel.text = "Что-то пошло не так, проверьте написанное"
            }
        }
    }
    var countOfTaping: Int = 0
    @IBAction func didClickShowPassword(_ sender: Any) {
        if countOfTaping % 2 == 0 /*&& passwordAccaunt.text != "" */ {
            passwordTextField.isSecureTextEntry = false
            countOfTaping += 1
        } else /*if passwordAccaunt.text != nil */{
            passwordTextField.isSecureTextEntry = true
            countOfTaping += 1
        }
    }
    
}
