//
//  ViewController.swift
//  ToDo
//
//  Created by Sunggon Park on 2024/03/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var toDoTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var toDoList: [ToDo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviation()
        setupTableView()
        fetchData()
    }

    private func setupNaviation() {
        navigationItem.rightBarButtonItem = makeBarButtonItem()
    }
    
    private func setupTableView() {
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
    }
    
    private func fetchData() {
        let fetchRequest = ToDo.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        do {
            toDoList = try context.fetch(fetchRequest)
            toDoTableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func makeBarButtonItem() -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addToDoItem))
        barButtonItem.tintColor = .black
        
        return barButtonItem
    }
    
    @objc private func addToDoItem() {
        presentAddToDoVC()
    }
    
    private func presentAddToDoVC(data: ToDo? = nil) {
        let addToDoVC = AddToDoViewController(nibName: "AddToDoViewController", bundle: nil)
        addToDoVC.delegate = self
        
        if data != nil {
            addToDoVC.toDo = data
        }
        
        present(addToDoVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell else {
            fatalError("Failed to downcast to ToDoTableViewCell")
        }
        guard let toDoData = toDoList?[indexPath.row] else {
            fatalError("Failed to get todo data")
        }
        cell.toDo = toDoData

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let data = toDoList?[indexPath.row] else { return }
        let addToDoVC = AddToDoViewController(nibName: "AddToDoViewController", bundle: nil)
        addToDoVC.delegate = self
        
        presentAddToDoVC(data: data)
    }
}

extension ViewController: AddToDoViewControllerDelegate {
    func reloadTableViewData() {
        fetchData()
    }
}
