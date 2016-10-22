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

class FeedManager: NSObject, UITableViewDataSource {
    var moviesArray = [Movie]()
    var filteredMovies = [Movie]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: MovieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        let movie = moviesArray[indexPath.row]
        movieCell.imageUrl = movie.imageUrl
        movieCell.activityIndicator.hidesWhenStopped = true
        movieCell.activityIndicator.startAnimating()
        
        return movieCell
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension FeedManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movieCell = cell as! MovieCell
        let movie = moviesArray[indexPath.row]
        
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
}
