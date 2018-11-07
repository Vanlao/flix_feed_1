//
//  SuperHoreViewController.swift
//  flix_feed_1
//
//  Created by Tu Pham on 10/2/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit

class SuperHeroViewController: UIViewController, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    //var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        //set up layout for posters in SuperheroViewController.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let CellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (CellsPerLine - 1)
        let width = collectionView.frame.size.width
        let wide = (width / CellsPerLine) - (interItemSpacingTotal / CellsPerLine) //initial width of a cell minus spacing per cell = actual width for a cell to fit)
        layout.itemSize = CGSize(width: wide, height: wide * 3/2) //height ratio may varies.
        
        FecthMovies() //fetch poster and any info from API on view controller.
    } 
    
    func FecthMovies(){ //copied from NowPlayingViewcontroller.
        //requesting url from the API database
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieList = dataDictionary["results"] as! [[String: Any]]
                self.movies = movieList
                self.collectionView.reloadData()
                //self.refreshControl.endRefreshing()
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    //same as tableView in NowPlayingViewController with small tweaks.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusePosterCell", for: indexPath) as! ReusePosterCell
        let movie = movies[indexPath.item] //use "item" instead of "row".
        if let PosterPathString = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let PosterURL = URL(string: baseURLString + PosterPathString)!
            cell.posterImageLabel.af_setImage(withURL: PosterURL)
            
        }
        return cell
    }
    //look at NowPlayingViewController for reference.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewControl = segue.destination as! DetailViewController
            detailViewControl.movieDetail = movie
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
