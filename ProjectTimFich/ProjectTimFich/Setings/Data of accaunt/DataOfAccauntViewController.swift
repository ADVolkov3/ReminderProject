//
//  DataOfAccauntViewController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 06.07.2021.
//

import UIKit

class DataOfAccauntViewController: UIViewController {
    
    var user: [Person] = []
    
    func setUserWhichSignIn(logIn: [Person]) {
        user = logIn
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var surNameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = ViewController()
        user = view.getPersonWhichLogIn()
        loginLabel.text = user[0].login
        emailLabel.text = user[0].email
        nameLabel.text = user[0].name
        surNameLabel.text = user[0].surName
        passwordLabel.text = user[0].password
        print(user[0].password)
        super.viewWillAppear(true)
    }
}
