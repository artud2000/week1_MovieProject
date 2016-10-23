//
//  SearchManager.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/18/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit
let SEARCH_NOTIFICATION = "searchAction"
let RELOAD_SEARCH_ARRAY = "reloadSearchArray"

final class SearchManager: NSObject, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SEARCH_NOTIFICATION), object: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SEARCH_NOTIFICATION), object: searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SEARCH_NOTIFICATION), object: nil)
        searchBar.resignFirstResponder()
    }
}
