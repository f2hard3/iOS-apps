//
//  OnboaringViewController.swift
//  OnboardingView
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class OnboaringViewController: UIViewController {
    var image: UIImage?
    var titleText: String?
    var descriptionText: String?
    

    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        mainImage.image = image
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
