//
//  ToDoListViewController.swift
//  swiftProject
//
//  Created by Александр on 10.07.2021.
//

import UserNotifications
import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var tasks = [ToDoList]()
    @IBAction func didTapAdd() {
        guard let vc = storyboard?.instantiateViewController(identifier: "entry") as? EntryViewController else {
            return
        }

        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = ToDoList(title: title, data: date, id: "id_\(title)")
                self.tasks.append(new)
                self.tableView.reloadData()

                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body

                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                          from: targetDate),
                                                            repeats: false)

                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
//    @IBAction func didTapTest() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
//            if success {
//                self.scheduleTest()
//            }
//            else if error != nil {
//                print("error occurred")
//            }
//        })
//    }
//    func scheduleTest() {
//        let content = UNMutableNotificationContent()
//        content.title = "Hello"
//        content.sound = .default
//        content.body = "My long body. My long body. My long body. My long body. My long body. My long body. "
//
//        let targetDate = Date().addingTimeInterval(10)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
//                                                                                                  from: targetDate),
//                                                    repeats: false)
//
//        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//            if error != nil {
//                print("something went wrong")
//            }
//        })
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension ToDoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row].title
        let date = tasks[indexPath.row].data

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date)

        cell.textLabel?.font = UIFont(name: "Arial", size: 25)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
        return cell
    }
}

struct ToDoList {
    let title: String
    let data: Date
    let id: String
}
