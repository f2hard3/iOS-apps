//
//  ViewController.swift
//  SettingCloneApp
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    var cellData = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()     
        
        setSettingTableView()
        
        setCellData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
        
    private func setSettingTableView() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.register(
            UINib(nibName: "ProfileTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ProfileTableViewCell"
        )
        settingTableView.register(
            UINib(nibName: "MenuTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MenuTableViewCell"
        )
    }
    
    private func setCellData() {
        cellData.append(
            [SettingModel(leftImageName: "person.crop.circle", title: "Sign in to your iPhone", description: "Set up iCloud, the App Store, and more.", rightImageName: nil)
            ]
        )
        
        cellData.append(
            [SettingModel(leftImageName: "gear", title: "General", description: nil, rightImageName: "chevron.right"),
             SettingModel(leftImageName: "accessibility", title: "Accessibility", description: nil, rightImageName: "chevron.right"),
             SettingModel(leftImageName: "hand.raised.fill", title: "Privacy", description: nil, rightImageName: "chevron.right"),
            ]
        )
        
        cellData.append(
            [SettingModel(leftImageName: "key", title: "Password", description: nil, rightImageName: "chevron.right"),
            ]
        )
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {
                fatalError("Error downcasting ProfileTableViewCell")
            }
            let data = cellData[indexPath.section][indexPath.row]
            cell.profileImageView.image = UIImage(systemName: data.leftImageName)
            cell.profileTitle.text = data.title
            cell.profileDescription.text = data.description
            cell.profileDescription.font = .systemFont(ofSize: 12)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else {
            fatalError("Error downcasting MenuTableViewCell")
        }
        let data = cellData[indexPath.section][indexPath.row]
        cell.menuImage.image = UIImage(systemName: data.leftImageName)
        cell.menuTitle.text = data.title
        cell.goToImage.image = UIImage(systemName: data.rightImageName ?? "")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let appleIDVC = AppleIDViewController(nibName: "AppleIDViewController", bundle: nil)
            present(appleIDVC, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            guard let generalTableVC = UIStoryboard(name: "GeneralTableViewController", bundle: nil).instantiateViewController(withIdentifier: "GeneralTableViewController") as? GeneralTableViewController else {
                fatalError("Error downcasting to GeneralTableViewController")
            }
            
            navigationController?.pushViewController(generalTableVC, animated: true)
        }
    }
        
}

