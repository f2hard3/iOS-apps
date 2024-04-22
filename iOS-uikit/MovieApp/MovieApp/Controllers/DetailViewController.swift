//
//  DetialViewController.swift
//  MovieApp
//
//  Created by Sunggon Park on 2024/03/21.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    @IBOutlet weak var movieContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }
    
    var movieResult: MovieResult?
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupVideo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        player?.pause()
    }
    
    private func setupViews() {
        titleLabel.text = movieResult?.title
        descriptionLabel.text = movieResult?.longDescription
    }
    
    func setupVideo() {
        guard let urlString = movieResult?.previewUrl else { return }
        guard let url = URL(string: urlString) else { return }
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = movieContainerView.bounds
        movieContainerView.layer.addSublayer(playerLayer)
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        player?.play()
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        player?.pause()
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
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
