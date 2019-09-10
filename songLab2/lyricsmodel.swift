//
//  lyricsmodel.swift
//  songLab2
//
//  Created by Phoenix McKnight on 9/9/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit
struct LyricsWrapper:Codable{
    let message:Messages
}
struct Messages:Codable{
    let body:Bodies
}
struct Bodies:Codable{
    let lyrics:Lyrics
}
struct Lyrics:Codable{
    let lyrics_body:String
}
