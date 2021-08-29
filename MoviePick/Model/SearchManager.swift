//
//  SearchManager.swift
//  MoviePick
//
//  Created by Rosy Wanasinghe on 27/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchManager {
    
    var searchResultsArray = [String]()
    
    let searchURL = "https://api.themoviedb.org/3/search/movie?api_key=c51a0c1eed541d73b9bbc223e62db7bc&language=en-US&page=1&include_adult=false&query="
    
    func generateSearchResults(with input: String) {
        
        let search = input.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "\(searchURL)\(search)"
        
        searchResultsArray = []
        
        AF.request(urlString).responseJSON { response in
            
            let json: JSON = JSON(response.value)
            
            let results = json["results"].arrayValue
            
            for result in results {
                let newResult = result["title"]
                self.searchResultsArray.append(newResult.stringValue)
            }
            
            print(self.searchResultsArray)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endingSearchResults"), object: nil)
            
        }
        
    }
    
    
}
