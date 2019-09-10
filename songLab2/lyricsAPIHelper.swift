//
//  lyricsAPIHelper.swift
//  songLab2
//
//  Created by Phoenix McKnight on 9/9/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit


class LyricsApiHelper {
    static let shared = LyricsApiHelper()
    private init () {}
    
    
    
    func getLyrics(track:Int,completionHandler: @escaping(Result<Lyrics,AppError>) -> ()) {
        let urlStr = "http://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=\(track)&apikey=3445509192b50cd7ccfe4df777f38cb2"
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do { let lyrics = try JSONDecoder().decode(LyricsWrapper.self, from: data)
                    completionHandler(.success(lyrics.message.body.lyrics))
                } catch {
                    completionHandler(.failure(.networkError))
                }
            }
        }
    }
}


