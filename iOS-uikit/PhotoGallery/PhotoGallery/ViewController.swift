//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Sunggon Park on 2024/03/20.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var fetchAssets: PHFetchResult<PHAsset>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupCollectionView()
    }
    
    private func setupNavigation() {
        title = "Photo Gallery"
        
        let photoItem = makeBarButtonItem(imageName: "photo.on.rectangle", selector: #selector(checkPermission))
        let refreshItem = makeBarButtonItem(imageName: "arrow.clockwise", selector: #selector(refreshPhoto))
        navigationItem.rightBarButtonItem = photoItem
        navigationItem.leftBarButtonItem = refreshItem
    }
    
    private func setupCollectionView() {
        photoCollectionView.dataSource = self
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 1) / 2, height: 200)
        collectionViewLayout.minimumInteritemSpacing = 1
        collectionViewLayout.minimumLineSpacing = 1
        photoCollectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func makeBarButtonItem(imageName: String, selector: Selector) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(systemName: imageName), style: .done, target: self, action: selector)
        item.tintColor = .black.withAlphaComponent(0.7)
        
        return item
    }
    
    @objc private func checkPermission() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        if status == .authorized || status == .limited {
            self.showPhotoGallery()
        } else if status == .denied {
            self.showAlert()
        } else if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { _ in
                DispatchQueue.main.async {
                    self.checkPermission()
                }
            }
        }
    }
    
    private func showPhotoGallery() {
        let library = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Please activate the access to photo library.",
                                      message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Go to settings", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }))
        present(alert, animated: true)
    }
    
    @objc private func refreshPhoto() {
        photoCollectionView.reloadData()
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchAssets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Failed to downcast t0 PhotoCollectionViewCell")
        }
        
        if let asset = fetchAssets?[indexPath.row] {
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //        let identifiers = results.map(\.assetIdentifier)
        let identifiers = results.map{ $0.assetIdentifier ?? "" }
        fetchAssets = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        
        photoCollectionView.reloadData()
        
        dismiss(animated: true)
    }
    
}
