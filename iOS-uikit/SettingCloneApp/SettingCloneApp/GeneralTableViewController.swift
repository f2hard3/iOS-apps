//
//  GeneralTableViewController.swift
//  SettingCloneApp
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

struct GeneralModel {
    let title: String
}

class GeneralTableViewCell: UITableViewCell {
  
    @IBOutlet weak var generalTitle: UILabel!
    @IBOutlet weak var generalImage: UIImageView! {
        didSet {
            generalImage.image = UIImage(systemName: "chevron.right")
        }
    }
}

class GeneralTableViewController: UITableViewController {
    var generalData = [[GeneralModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTable()
        setData()
    }
    
    private func setNavigation() {
        title = "General"
    }
    
    private func setTable() {
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    private func setData() {
        generalData.append([
            GeneralModel(title: "About")
        ])
        
        generalData.append([
            GeneralModel(title: "Keyboard"),
            GeneralModel(title: "Game Controller"),
            GeneralModel(title: "Fonts"),
            GeneralModel(title: "Language & Region"),
            GeneralModel(title: "Dictionary"),
        ])
        
        generalData.append([
            GeneralModel(title: "Reset")
        ])
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return generalData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generalData[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell else {
            fatalError("Error downcasting GeneralTableViewCell")
        }
        let data = generalData[indexPath.section][indexPath.row]
        cell.generalTitle.text = data.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

