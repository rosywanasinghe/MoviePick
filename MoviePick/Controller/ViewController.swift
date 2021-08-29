//
//  ViewController.swift
//  MoviePick
//
//  Created by Rosy Wanasinghe on 18/8/21.
//

import UIKit
import SDWebImage
import SwipeCellKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    let movieCellColour = UIColor(named: "383838")
    let movieManager = MovieManager()
    let searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieTableView.backgroundColor = movieCellColour
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieReusableCell")
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "endingAddMovieSelection"), object: nil)
        
    }
    
    @objc func refresh() {
        movieTableView.reloadData()
    }

    
    @IBAction func addMovieButtonPressed(_ sender: UIButton) {
        
        searchManager.searchResultsArray = []
        performSegue(withIdentifier: "goToSearchView", sender: self)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SearchViewController
        
        destinationVC.movieManager = movieManager
        destinationVC.searchManager = searchManager

    }
    


}


//MARK: - TableView Datasource Methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieManager.movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReusableCell", for: indexPath) as! MovieCell
//        cell.textLabel?.text = "Test"
//        cell.textLabel?.textColor = UIColor.white
//
//        cell.backgroundColor = UIColor.blue
//        cell.backgroundColor = movieCellColour
        
        cell.title.text = movieManager.movieArray[indexPath.row].title
        cell.tagline.text = movieManager.movieArray[indexPath.row].tagline
        cell.runtime.text = movieManager.movieArray[indexPath.row].runtime
        cell.genre.text = movieManager.movieArray[indexPath.row].genre
        
        cell.poster.sd_setImage(with: URL(string: movieManager.movieArray[indexPath.row].imageURLString), completed: nil)
        
        cell.delegate = self
        
        return cell
        
    }
    
    
}

// MARK: - Tableview Delegate Methods

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 126
    }
    
    
}

// MARK: - SwipeTableViewCell Delegate Methods

extension ViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.movieManager.deleteMovie(with: indexPath.row)
            self.movieTableView.reloadData()
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        return options
    }
    
}
