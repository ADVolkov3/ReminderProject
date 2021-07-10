//
//  ScreenOfAddingViewController.swift
//  ProjectTimFich
//
//  Created by Тимур Миргалиев on 08.07.2021.
//

import UIKit
import UserNotifications

struct Notification: Codable {
    var text: String
    var owner: Person
    
}

class ScreenOfAddingViewController: UIViewController {
    
    var buf: [Notification] = []
    var notifications: [Notification] = []
    var user: [Person] = []
    
    @IBOutlet weak var textFieldView: UITextView!
    @IBOutlet weak var backgroundView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = ViewController()
        user = view.getPersonWhichLogIn()
        super.viewWillAppear(true)
    }
    
    @IBAction func didClickAddToArrayOfNotifications(_ sender: Any) {
        notifications.append(Notification(text: textFieldView.text, owner: user[0]))
        UserDefaults.standard.set(try? PropertyListEncoder().encode(notifications), forKey: "Notifications")
        if let data = UserDefaults.standard.object(forKey: "Notifications") as? Data {
            buf = try! PropertyListDecoder().decode(Array<Notification>.self, from: data)
            print(buf)
        }
    }
}
