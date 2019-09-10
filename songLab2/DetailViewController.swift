//
//  ViewController.swift
//  songLab2
//
//  Created by Phoenix McKnight on 9/9/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var passingInfo:TrackList!
    var lyrics:Lyrics? {
        didSet {
            setUP()
        }
    }
    
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var textViewOutlet: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       getArtistAPIHelper(tracks: passingInfo.track.track_id)
        // Do any additional setup after loading the view.
    }
    func getArtistAPIHelper(tracks:Int) {
        LyricsApiHelper.shared.getLyrics(track: tracks) {
            (results) in
            DispatchQueue.main.async {
                
                
                switch results {
                case .success(let lyricsFromOnline):
                    self.lyrics = lyricsFromOnline
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    func setUP() {
        if passingInfo.track.has_lyrics == 0 {
            textViewOutlet.text = "Lyrics aren't available for this song"
        } else {
        textViewOutlet.text = lyrics?.lyrics_body
        }
        labelOutlet.text = "Song Lyrics : \(passingInfo.track.track_name)"
    }

}

