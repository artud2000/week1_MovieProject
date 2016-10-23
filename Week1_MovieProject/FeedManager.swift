//
//  FeedManager.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/17/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

let REQUEST_MORE_DATA_NOTIFICATION = "requestMoreData"
let RELOAD_DATA_NOTIFICATION = "reloadData"

final class FeedManager: NSObject, UITableViewDataSource {
    var moviesArray = [Movie]()
    internal var filteredMovies = [Movie]()
    internal var isSearching: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchAction(notification:)), name: NSNotification.Name(rawValue: SEARCH_NOTIFICATION), object: nil)
    }
    
    @objc private func searchAction(notification: NSNotification) {
        let searchString = notification.object != nil ? notification.object as! String : ""
        
        if searchString.characters.count > 0 {
            isSearching = true
        }
        
        if isSearching == true {
            filteredMovies = moviesArray.filter({ (movie: Movie) -> Bool in
                return movie.title.contains(searchString)
            })
        }
        
        if searchString.characters.count == 0 {
            isSearching = false
        }
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: RELOAD_DATA_NOTIFICATION), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return filteredMovies.count
        }
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: MovieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        var movie = moviesArray[indexPath.row]
        
        if isSearching == true {
            movie = filteredMovies[indexPath.row]
        }
        
        movieCell.imageUrl = movie.imageUrl
        movieCell.activityIndicator.hidesWhenStopped = true
        movieCell.activityIndicator.startAnimating()
        
        if movieCell.isSelected == true {
            movieCell.contentView.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        } else {
            movieCell.contentView.backgroundColor = UIColor.white
        }
        
        return movieCell
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension FeedManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movieCell = cell as! MovieCell
        
        var movie = moviesArray[indexPath.row]
        
        if isSearching == true {
            movie = filteredMovies[indexPath.row]
        }
        
        NetworkManager.downloadImageWithURL(url: movieCell.imageUrl) { (data: Data?) in
                DispatchQueue.main.async {
                    movieCell.imageView?.image = UIImage(data: data!)
                    movieCell.imageData = data
                    movieCell.activityIndicator.stopAnimating()
                    movieCell.movieTitleLabel.text = movie.title
                    movieCell.movieDescriptionLabel.text = movie.movieDescription
                    movieCell.setNeedsLayout()
                }
        }
        
        if ( indexPath.row == moviesArray.count - 1 ) {
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: REQUEST_MORE_DATA_NOTIFICATION), object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let movieCell = tableView.cellForRow(at: indexPath) as! MovieCell
        movieCell.movieDescriptionLabel.textColor = UIColor.black
        movieCell.movieTitleLabel.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let movieCell = tableView.cellForRow(at: indexPath) as! MovieCell
        movieCell.movieDescriptionLabel.textColor = UIColor.white
        movieCell.movieTitleLabel.textColor = UIColor.white
    }
}
