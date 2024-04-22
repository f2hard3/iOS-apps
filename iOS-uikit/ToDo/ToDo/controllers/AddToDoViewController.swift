//
//  AddToDoViewController.swift
//  ToDo
//
//  Created by Sunggon Park on 2024/03/21.
//

import UIKit
import CoreData

protocol AddToDoViewControllerDelegate: AnyObject {
    func reloadTableViewData() -> Void
}

class AddToDoViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: AddToDoViewControllerDelegate?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var toDo: ToDo? {
        didSet {
            isUpdate = true
        }
    }
    var isUpdate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupViews()
    }
    
    private func setupViews() {
        if isUpdate {
            saveButton.setTitle("Update", for: .normal)
            titleTextField.text = toDo!.title
            prioritySegmentedControl.selectedSegmentIndex = Int(toDo!.priority)
        } else {
            deleteButton.isHidden = true
        }
        
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        isUpdate ? updateData() : saveData()
        
        delegate?.reloadTableViewData()
        
        dismiss(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        deleteData()
        
        delegate?.reloadTableViewData()
        
        dismiss(animated: true)
    }
    
    private func saveData() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "ToDo", in: context) else { return }
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? ToDo else { return }
        object.id = UUID()
        object.title = titleTextField.text
        object.date = Date()
        object.priority = Int16(prioritySegmentedControl.selectedSegmentIndex)
        
        appDelegate.saveContext()
    }
    
    private func updateData() {
        do {
            let data = try fetchData()
            guard let data = data else { return }
            data.title = titleTextField.text
            data.date = Date()
            data.priority = Int16(prioritySegmentedControl.selectedSegmentIndex)
            
            appDelegate.saveContext()
        } catch {
            print(error)
        }
    }
    
    private func deleteData() {
        do {
            let data = try fetchData()
            guard let data = data else { return }
            
            context.delete(data)
            appDelegate.saveContext()
        } catch {
            print(error)
        }
    }
    
    private func fetchData() throws -> ToDo? {
        guard let id = toDo?.id else { return nil }
        
        let fetchRequest = ToDo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        let data = try context.fetch(fetchRequest)
        
        return data.first
    }
    
}
