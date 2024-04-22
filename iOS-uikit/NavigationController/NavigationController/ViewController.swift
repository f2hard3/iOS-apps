//
//  ViewController.swift
//  NavigationController
//
//  Created by Sunggon Park on 2024/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavigationTitleButton()
//        setupNavigationTitleImage()
//        makeNavBarBackButton()
//        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStatusBarNavigationBar()        
    }
    
    private func setupStatusBarNavigationBar() {
        navigationItem.title = "Main"
        statusBarView?.backgroundColor = .yellow
        navigationController?.navigationBar.backgroundColor = .yellow
        
//        let button1 = makeNavBarButton(name: "alarm.fill")
//        let button2 = makeNavBarButton(name: "alarm")
//        button2.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
//        navigationItem.rightBarButtonItems = [button1, button2]
        
        let button1 = makeButton(name: "alarm.fill")
        let button2 = makeButton(name: "alarm")
        let stackview = UIStackView(arrangedSubviews: [button1, button2])
        stackview.distribution = .equalSpacing
        stackview.spacing = 5
        let barButtonItem = UIBarButtonItem(customView: stackview)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .orange.withAlphaComponent(0.3)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.title = "Main"
    }
    
    private func setupNavigationTitleButton() {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .orange
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        navigationItem.titleView = button
    }

    @objc private func buttonTapped() {
        print("tapped")
    }
    
    private func setupNavigationTitleImage() {
        let imageView = UIImageView(image: UIImage(named: "logoSample.jpg"))
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        navigationItem.titleView = imageView
    }
    
    private func makeNavBarBackButton() {
        guard let image = UIImage(named: "blueCircleArrowR") else { return }
        let newImage = resizeImage(with: image, size: CGSize(width: 40, height: 40)).withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = newImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = newImage
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.backButtonTitle = ""
//        navigationItem.backButtonTitle = "戻る"
//        navigationItem.backBarButtonItem = UIBarButtonItem(systemItem: .bookmarks)
    }
    
    private func resizeImage(with image: UIImage, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image { context in
            image.draw(in: rect)
        }
        
        return newImage
    }
    
    private func makeNavBarButton(name: String) -> UIBarButtonItem {
        let image = UIImage(systemName: name)?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(buttonTapped))
        
        return button
    }
    
    private func makeButton(name: String) -> UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: name, withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)        
        
        return button
    }
}

