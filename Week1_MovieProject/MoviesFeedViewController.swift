//
//  MoviesFeedViewController.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/17/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

class MoviesFeedViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet var dataProvider: FeedManager!
    var currentPage: Int = 1
    var currentMode: String = "now_playing"
    
    lazy var refreshControl: UIRefreshControl = {
        let tempRefresh = UIRefreshControl()
        tempRefresh.attributedTitle = NSAttributedString(string:"Pull to Refresh")
        tempRefresh.addTarget(self, action: #selector(self.pullDownTriggered(refreshControl:) ), for: UIControlEvents.primaryActionTriggered)
        return tempRefresh
    }()
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.increasePaginationForDataRequest), name: NSNotification.Name(rawValue: REQUEST_MORE_DATA_NOTIFICATION), object: nil)
        moviesTableView.delegate = dataProvider
        moviesTableView.dataSource = dataProvider
        moviesTableView.insertSubview(refreshControl, at: 0)
        
        refreshData()
    }
    
    func increasePaginationForDataRequest() {
        currentPage = currentPage + 1
        refreshData()
    }
    
    func pullDownTriggered(refreshControl: UIRefreshControl) {
        currentPage = 1
        refreshData()
    }
    
    func refreshData() {
        if self.parent?.tabBarController?.selectedIndex == 0 {
            currentMode = "now_playing"
        } else {
            currentMode = "top_rated"
        }
        
        NetworkManager.retrieveFeed(type: currentMode, page: currentPage) { (movies: [Movie]?, currentPage: Int) in
            DispatchQueue.main.async {
                if self.dataProvider.moviesArray.count == 0 {
                    self.dataProvider.moviesArray = movies!
                } else {
                    self.dataProvider.moviesArray += movies!
                }
                self.moviesTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell: MovieCell = sender as! MovieCell
        let vc: MovieDetailViewController = segue.destination as! MovieDetailViewController
        vc.imageData = cell.imageData
        vc.movieDescription = cell.movieDescriptionLabel.text
        vc.movieTitle = cell.movieTitleLabel.text
    }
}
