//
//  modelSong.swift
//  songLab2
//
//  Created by Phoenix McKnight on 9/9/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

struct ArtistWrapper:Codable{
    let message:Message
}
struct Message:Codable{
    let body:Body
}
struct Body:Codable{
    let track_list:[TrackList]
}
struct TrackList:Codable {
    let track: Track
}
struct Track:Codable{
    let track_id:Int
    let track_name:String
    let  has_lyrics:Int
    let artist_name:String
}





