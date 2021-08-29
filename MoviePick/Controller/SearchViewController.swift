//
//  SearchViewController.swift
//  MoviePick
//
//  Created by Rosy Wanasinghe on 25/8/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var movieManager = MovieManager()
    var searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        searchTableView.backgroundColor = UIColor(named: "383838")
        
        searchBar.delegate = self
        searchBar.barStyle = UIBarStyle.black
        searchBar.searchTextField.textColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "endingSearchResults"), object: nil)
    }
    
    @objc func refresh() {
        searchTableView.reloadData()
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endingAddMovieSelection"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK: - SearchTableView Datasource Methods

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchManager.searchResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchReusableCell", for: indexPath)

        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.blue
        cell.backgroundColor = UIColor(named: "383838")
        
        cell.textLabel?.text = searchManager.searchResultsArray[indexPath.row]
        
        return cell
        
    }
    
}

// MARK: - SearchTableView Delegate Methods

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = searchManager.searchResultsArray[indexPath.row]
        movieManager.generateMovie(with: movie)
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Search bar methods

extension SearchViewController: UISearchBarDelegate {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        if let input = searchBar.text {
//            movieManager.generateMovie(with: input)
//            dismiss(animated: true, completion: nil)
//        }
//
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchManager.generateSearchResults(with: searchText)
        
    }
    
    
    
   
    
}


