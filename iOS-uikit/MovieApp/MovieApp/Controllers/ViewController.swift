//
//  ViewController.swift
//  MovieApp
//
//  Created by Sunggon Park on 2024/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let movieManager = MovieManager()
    var movieData: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        Task {
            do {
                movieData = try await movieManager.fetchMovieData(searchTerm: searchTerm)
                view.endEditing(true)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("Failed to downcast to MovieTableViewCell")
        }
        if let movie = movieData?.results[indexPath.row] {
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text = movie.shortDescription
            let price = movie.price?.description ?? ""
            let currency = movie.currency ?? ""
            cell.priceLabel.text = price + " " + currency
            
            if let imageUrl = movie.imageUrl {
                self.movieManager.fetchImage(url: imageUrl) { data in
                    DispatchQueue.main.async {
                        cell.movieImageView.image = UIImage(data: data)
                    }
                }
            }
            
            if let date = movie.date {
                cell.dateLabel.text = movieManager.formatDate(from: date)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController")
                as? DetailViewController else { return }
        detailVC.movieResult = self.movieData?.results[indexPath.row]
        
        present(detailVC, animated: true)
    }
    
    
}

