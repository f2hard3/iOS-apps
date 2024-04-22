//
//  ViewController.swift
//  SeeFood
//
//  Created by Sunggon Park on 2024/03/06.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciImage = CIImage(image:userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            
            detect(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true)
    }
    
    func detect(image: CIImage) {
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: config).model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results else {
                fatalError("Model failed to process image")
            }
            
            if let firstResult = results.first {
                let desc = firstResult.description
                
                if let openingIndex = desc.firstIndex(of: "\""), let closingIndex = desc.lastIndex(of: "\"") {
                    let startIndex = desc.index(after: openingIndex)
                    let endIndex = desc.index(before: closingIndex)
                    let extractedText = String(desc[startIndex...endIndex])
                    self.navigationItem.title = extractedText
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print("Error performing request: \(error)")
        }
    }
}

