//
//  NetworkManager.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/17/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation

let moviesURL: String = "https://api.themoviedb.org/3/movie"
let imageURLBasePath: String = "https://image.tmdb.org/t/p"
let moviesToken: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"

class NetworkManager: NSObject {
    class func retrieveFeed(type: String, page: Int, completionHandler: @escaping (_ data: [Movie]?, _ currentPage: Int) -> Void) {
        let requestURL = "\(moviesURL)/\(type)?api_key=\(moviesToken)&page=\(page)"
        let url: URL = URL(string: requestURL)!
        let request: URLRequest = URLRequest(url: url)
        let session: URLSession = URLSession.shared
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]{
                    print(responseDictionary)
                    completionHandler(fillMovieModel(movies: responseDictionary), responseDictionary["page"] as! Int)
                }
            } else {
                
            }
        })
        task.resume()
    }
    
    class func fillMovieModel(movies: [String: AnyObject]) -> [Movie] {
        let size = "w500"
        var arrayOfMovies: [Movie] = [Movie]()
        for movie in movies["results"] as! [[String: AnyObject]] {
            let tempMovie = Movie(title: movie["original_title"] as! String, movieDescription: movie["overview"] as! String, imageUrl: "\(imageURLBasePath)/\(size)/\(movie["poster_path"]!)")
            arrayOfMovies.append(tempMovie)
        }
        
        return arrayOfMovies
    }
    
    class func downloadImageWithURL(url: String, completionHandler: @escaping (_ imageData: Data?) -> Void) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if ( data != nil ) {
                    completionHandler(data)
                }
            })
            task.resume()
        } else {
            completionHandler(Data())
        }
    }
}
