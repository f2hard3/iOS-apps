//
//  PhotoCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Sunggon Park on 2024/03/20.
//

import UIKit
import PhotosUI

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func loadImage(asset: PHAsset) {
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil) { image, _ in
            self.photoImageView.image = image
        }
    }
}
