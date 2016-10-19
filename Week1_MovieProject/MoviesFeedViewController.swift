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
    
    lazy var refreshControl: UIRefreshControl = {
        let tempRefresh = UIRefreshControl()
        tempRefresh.attributedTitle = NSAttributedString(string:"Pull to Refresh")
        tempRefresh.addTarget(self, action: #selector(self.pullDownTriggered(refreshControl:) ), for: UIControlEvents.primaryActionTriggered)
        return tempRefresh
    }()
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.pullDownTriggered(refreshControl:)), name: NSNotification.Name(rawValue: REQUEST_MORE_DATA_NOTIFICATION), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchAction(notification:)), name: NSNotification.Name(rawValue: SEARCH_NOTIFICATION), object: nil)
        
        moviesTableView.delegate = dataProvider
        moviesTableView.dataSource = dataProvider
        moviesTableView.insertSubview(refreshControl, at: 0)
        
        refreshData()
    }
    
    func pullDownTriggered(refreshControl: UIRefreshControl) {
        refreshData()
    }

    func searchAction(notification: NSNotification) {
        print(notification)
    }
    
    func refreshData() {
        NetworkManager.retrieveFeed(type: "now_playing") { (movies: [Movie]?) in
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
        vc.movieDetailImageView.image = UIImage(data: cell.imageData)
    }
}
