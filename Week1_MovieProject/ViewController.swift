//
//  ViewController.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/17/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var feedContainerView: UIView!
    @IBOutlet var searchManager: SearchManager!
    
    lazy var moviesFeedViewController: MoviesFeedViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MoviesFeedViewController") as! MoviesFeedViewController
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addChildViewController(moviesFeedViewController)
        self.feedContainerView.addSubviewInContainerView(subView: moviesFeedViewController.view)
        moviesSearchBar.delegate = searchManager
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

