//
//  MovieManager.swift
//  MoviePick
//
//  Created by Rosy Wanasinghe on 18/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieManager {
    
    let infoURL = "https://api.themoviedb.org/3/movie/<MOVIE_ID>?api_key=<INSERT_API_KEY>"
    
    var movieIDURL = "https://api.themoviedb.org/3/search/movie?api_key=<INSERT_API_KEY>&language=en-US&query="
    
    var movieArray = [Movie]()
    
    
    func generateMovie(with name: String) {
        
        let movieName = name.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "\(movieIDURL)\(movieName)"
        
        AF.request(urlString).responseJSON { response in
            
            let json: JSON = JSON(response.value)
            
            let movieID = json["results"][0]["id"].stringValue
            
            self.addMovieItemIntoArray(with: movieID)
        }
        
        
    }
    
    
    func addMovieItemIntoArray(with movieID: String) {
        
        let urlString = infoURL.replacingOccurrences(of: "<MOVIE_ID>", with: movieID)
        
        AF.request(urlString).responseJSON { response in
            let json: JSON = JSON(response.value)
            
            let newMovie = Movie(title: json["title"].stringValue, tagline: json["tagline"].stringValue, runtime: "\(json["runtime"].stringValue) minutes", genre: json["genres"][0]["name"].stringValue, imageURLString: "https://image.tmdb.org/t/p/original/\(json["poster_path"].stringValue)")
            
            self.movieArray.append(newMovie)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endingAddMovieSelection"), object: nil)
            
        }
        
        
    }
    
    func deleteMovie(with index: Int) {
        
        movieArray.remove(at: index)
        
    }
    
    
    
    
}
