//
//  ArtistViewController.swift
//  songLab2
//
//  Created by Phoenix McKnight on 9/9/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class ArtistViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var searchBarOUTLET: UISearchBar!
    
    @IBOutlet weak var tableViewOUTLET: UITableView!
    
    var songList = [TrackList]() {
        didSet {
            self.tableViewOUTLET.reloadData()
        }
    }
    var usingFiltered = false
    var userSearchTerm: String? {
        didSet {
            self.tableViewOUTLET.reloadData()
        }
    }
    var filteredTrack: [TrackList]  {
        guard let userSearchTerm = userSearchTerm else {
            usingFiltered = true
            return songList
        }
        guard userSearchTerm != "" else {
           usingFiltered = true
            return songList
        }
        usingFiltered = true
        return songList
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.userSearchTerm = searchText
       getArtistName(name: searchText)
        
    }
   
    func getArtistName(name:String?) {
        ArtistApiHelper.shared.getArtist(name:name) { (results) in
            DispatchQueue.main.async {
                
                
                switch results {
                case .success(let songsFromOnline):
                    self.songList = songsFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    
  
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usingFiltered = false
        setUP()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if usingFiltered == true {
        return filteredTrack.count
        } else {
            return songList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = songList[indexPath.row]
        if let cell = tableViewOUTLET.dequeueReusableCell(withIdentifier: "artist") {
            cell.textLabel?.text = track.track.track_name
            cell.detailTextLabel?.text = track.track.artist_name
        
        return cell
        } else {
            return UITableViewCell()
        }
    }
    func setUP() {
        tableViewOUTLET.dataSource = self
        tableViewOUTLET.delegate = self
        searchBarOUTLET.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
       
        if usingFiltered == true {
            storyBoard.passingInfo = filteredTrack[indexPath.row]
        } else {
            storyBoard.passingInfo = songList[indexPath.row]
        }
        navigationController?.pushViewController(storyBoard, animated: true)
    }
}
